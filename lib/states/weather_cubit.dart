import 'dart:developer';
import 'dart:async';

import 'package:bweather_repository/bweather_repository.dart';
import 'package:bweatherflutter/states/forecast/city_state.dart';
import 'package:bweatherflutter/states/forecast/weather_state.dart';
import 'package:bweatherflutter/states/settings_cubit.dart';
import 'package:bweatherflutter/utils/status.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class WeatherCubit extends HydratedCubit<WeatherState>{
    final ForecastRepository __repository;
    final SettingsCubit __settingsCubit;

    late void Function()? __toHomeListener;
    set toHomeListener(void Function() homeListener){
        __toHomeListener = homeListener;
    }

    late StreamSubscription<List<ConnectivityResult>> subscription;

    WeatherCubit(this.__settingsCubit, { ForecastRepository? repository }): __repository = repository ?? ForecastRepository(), super(const WeatherState()){
        __settingsCubit.weatherCubit = this;

        subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
            if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.ethernet)) {
                if(state.status.isFailure){
                    init();
                }else{
                    reload();
                }
            }
        });

        if(state.cities.isNotEmpty){
            initForecast();
        }
        init();
    }

    void init (){
        emit(state.copy(status: StateStatus.loading, message: "Getting user current location"));

        __determinePosition().then((position){
            if(position != null){
                placemarkFromCoordinates(position.latitude, position.longitude).then((placemarks) async{
                    //City city = City(name: placemarks[0].locality!, country: placemarks[0].country!, elavation: position.altitude, latitude: position.latitude, longitude: position.longitude);
                    log("looking positional data of ${placemarks[0].locality!}");
                    List<City> list =  await __repository.search(placemarks[0].locality!);
                    List<CityState> init = [...state.cities];
                    if(init.isNotEmpty){
                        /*if(init.first.city.country != list.first.country && init.first.city.name != list.first.name){
                            ;
                        }*/
                        init.removeAt(0);
                        init.insert(0, CityState(city: list.first));
                    }else if(init.isEmpty){
                        init.add(CityState(city: list.first));
                    }
                    emit(state.copy(cities: init, status: StateStatus.success));          
                }).onError((error, strace){
                    log("location error:", error: error);
                    emit(state.copy(error: error, status: StateStatus.failure, message: "Encountered an unexpected error, check your internet connection"));
                }).whenComplete((){
                    initForecast();
                });
            }
        }).onError((error, strace){
            log("location error:", error: error);
            emit(state.copy(error: error, status: StateStatus.failure, message: "Encountered an unexpected error, check your internet connection"));
        });
    }

    Future<Position?> __determinePosition() async {
        bool serviceEnabled;
        LocationPermission permission;

        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled && state.cities.isEmpty) {
            return Future.error('Location services are disabled.');
        }

        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied && state.cities.isEmpty) {
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied) {
                await SystemNavigator.pop();
                emit(state.copy(message: "Location permission is needed to run the Application", status: StateStatus.failure));
                return Future.error('Location permissions are denied');
            }
        }
      
        if (permission == LocationPermission.deniedForever && state.cities.isEmpty) {
            emit(state.copy(message: "Location permission is needed to run the Application", status: StateStatus.failure));
            return Future.error('Location permissions are permanently denied, we cannot request permissions.');
        }

        if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
            return await Geolocator.getCurrentPosition();
        }
        return null;
    }

    void __updateCity(int index, CityState cityState){
        List<CityState> init = [...state.cities]..replaceRange(index, index + 1, [cityState]);
        emit(state.copy(cities: init));
    }

    Future<void> forecast(CityState cityState) async{
        int index = state.cities.indexOf(cityState);

        cityState = cityState.copy(status: StateStatus.loading, message: "Getting weather forecast for ${cityState.city.name}");
        __updateCity(index, cityState);
        try{
            Units units = Units(
                temp_unit: __settingsCubit.state.temp_unit, 
                precipitation_unit: __settingsCubit.state.precipitation_unit,
                wind_speed_unit: __settingsCubit.state.wind_speed_unit
            );

            City response = await __repository.getWeather(cityState.city, units: units);
            __updateCity(index, cityState.copy(city: response, status: StateStatus.success));
        }catch(error){
            __updateCity(index, cityState.copy(error: error, status: StateStatus.failure));
            log("Weather error - ${cityState.city.name}", error: error);
        }
    }

    void initForecast(){
        if(state.status.isSuccess){
            for (var cityState in state.cities) { 
                forecast(cityState);
            }
        }
    }

    bool exist(String name){
        for (var element in state.cities) {
            if(element.city.name == name){
                return true;
            }
        }
        return false;
    }

    Future<void> addCity(City city) async{
        if(!exist(city.name )){
            List<CityState> init = [...state.cities, CityState(city: city)];
            emit(state.copy(cities: init));
            
            forecast(init.last);
        }
    }

    Future<void> requestCity(String? name) async{
        if(name != null || name!.isNotEmpty){
            try{
                City city = ( await __repository.search(name)).first;

                await addCity(city);
            }catch(error){
                log("adding City error", error: error);
                Future.error("Adding $name city failed, check your internet connection try again");
            }
        }
    }

    void remove(int index){
        try{
            List<CityState> init = [...state.cities]..removeAt(index);
            emit(state.copy(cities: init));
        }catch(error){
            log("location remove error", error: error);
        }
    }

    void toHome(){
        if(__toHomeListener != null){
            __toHomeListener!();
        }
    }

    Future<void> reload({ bool force = false }) async{
        for (var element in state.cities) {
            if(element.status.isFailure || force){
                forecast(element);
            }
        }
    }

    Future<void> reloadCityForecast(CityState cityState) async{
        await forecast(cityState);
    }

    @override
    WeatherState? fromJson(Map<String, dynamic> json) {
        return WeatherState.fromJson(json);
    }

    @override
    Map<String, dynamic>? toJson(WeatherState state) {
        return state.toJson();
    }
}