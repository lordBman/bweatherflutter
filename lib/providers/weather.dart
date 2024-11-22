import 'dart:async';
import 'dart:developer';

import 'package:bweatherflutter/providers/settings.dart';
import 'package:bweatherflutter/utils/cities.dart';
import 'package:bweatherflutter/utils/objectio.dart';
import 'package:bweatherflutter/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

import 'package:uno/uno.dart';

class ForecastState{
    City city;
    Result? result;
    bool loading = true;
    bool isError = false;
    String message;
    dynamic error;

    ForecastState({ required this.city, this.message = "" });
}

class WeatherNotifier extends ChangeNotifier{
    bool __loading = true, __isError = false, __proceeded = false;
    bool get loading=> __loading;
    bool get isError=> __isError;

    String __message = "Getting user current location";
    String get message=> __message;

    dynamic __error;
    dynamic get error => __error;

    final List<ForecastState> __savedCities = [];
    List<ForecastState> get savedCities => __savedCities;

    late void Function() __toHomeListener;
    late void Function() __proceedListener;

    City? __location;
    City? get location => __location;

    final SettingsNotifier __settingsNotifier;

    WeatherNotifier({ required SettingsNotifier settingsNotifier }): __settingsNotifier = settingsNotifier{
        __settingsNotifier.weatherNotifier = this;
        __message = "Checking for saved location";
        notifyListeners();
        findLocation().then((location)=> __location = location).whenComplete((){
            if(location != null){
                __savedCities.add(ForecastState(city: __location!));

                __message = "Checking for saved Cites";
                notifyListeners();
                find().then((saved)=> __savedCities.addAll(saved)).whenComplete((){
                    __loading = false;
                    notifyListeners();

                    __proceedListener();
                    __proceeded = true;
                }).whenComplete(()=> init());
            }else{
                init();
            } 
        });
    }

    Future<Position?> __determinePosition() async {
        bool serviceEnabled;
        LocationPermission permission;

        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled && location == null) {
            return Future.error('Location services are disabled.');
        }

        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied && location == null) {
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied) {
                await SystemNavigator.pop();
                __isError = true;
                __message = "Location permission is needed to run the Application";
                return Future.error('Location permissions are denied');
            }
        }
      
        if (permission == LocationPermission.deniedForever && location == null) {
            __isError = true;
            __loading = false;
            __message = "Location permission is needed to run the Application"; 
            return Future.error('Location permissions are permanently denied, we cannot request permissions.');
        }

        if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
            return await Geolocator.getCurrentPosition();
        }
        return null;
    }

    Future<void> forecast(ForecastState savedCity) async{
        savedCity.message = "Getting weather forecast for ${savedCity.city.name}";
        savedCity.loading = true;
        savedCity.isError = false;
        notifyListeners();

        try{
            Map<String, String> params = {
                "latitude" : savedCity.city.latitude.toString(),
                "longitude": savedCity.city.longitude.toString(),
                "temperature_unit": __settingsNotifier.tempUnit.serialize(),
                "wind_speed_unit": __settingsNotifier.windSpeedUnit.serialize(),
                "precipitation_unit": __settingsNotifier.precipitationUnit.serialize(),
                "current": "temperature_2m,relative_humidity_2m,apparent_temperature,is_day,rain,weather_code,pressure_msl,surface_pressure,wind_speed_10m,wind_direction_10m,wind_gusts_10m,precipitation,cloud_cover",
                "hourly": "temperature_2m,relative_humidity_2m,dew_point_2m,apparent_temperature,precipitation_probability,rain,weather_code",
                "daily": "weather_code,temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,sunrise,sunset,precipitation_sum,rain_sum,wind_speed_10m_max,wind_gusts_10m_max",
                //"timezone": DateTime.now().timeZoneName
            };

            savedCity.result = Result.fromJson((await __weatherAPI.get("/", params: params)).data);
            savedCity.loading = false;
        }catch(error){
            savedCity.isError = true;
            savedCity.error = error;
            if(error is UnoError){
                log("Weather error - ${savedCity.city.name}:${error.request!.uri.toString()}", error: error);
            }else{
                log("Weather error - ${savedCity.city.name}", error: error);
            }
        }
        savedCity.loading = false;
        notifyListeners();
    }

    void init (){
        __message = "Getting user current location";
        __isError = false;
        __loading = true;
        notifyListeners();

        __determinePosition().then((position){
            if(position != null){
                placemarkFromCoordinates(position.latitude, position.longitude).then((placemarks){
                    double offset = DateTime.now().timeZoneOffset.inHours.toDouble() + DateTime.now().timeZoneOffset.inMinutes.toDouble() / 60;
                    City city = City(name: placemarks[0].locality!, country: placemarks[0].country!, timezone: offset, latitude: position.latitude, longitude: position.longitude);
                    if(__location != null && __location?.country != city.country && __location?.name != city.name){
                        __savedCities.removeAt(0);
                        __savedCities.insert(0, ForecastState(city: city));
                    }else if(__location == null){
                        __savedCities.insert(0, ForecastState(city: city));
                    }
                    __location = city;
                    saveLocation(city);          
                }).onError((error, strace){
                    __isError = true; 
                    __error = error;
                    __message = "Encountered an unexpected error, check your internet connection";
                }).whenComplete((){
                    __loading = false;
                    notifyListeners();
                    if(location != null && !__proceeded){
                        __proceedListener();
                        __proceeded = true;
                    }
                });
            }
        }).onError((error, strace){
            __loading = false;
            __error = error;
            notifyListeners();
        });
    }

    void initForecast(){
        if(!__isError){
            for (var savedCity in __savedCities) { 
                forecast(savedCity);
            }
        }
    }

    bool exist(City city){
        for (var element in __savedCities) {
            if(element.city.name == city.name){
                return true;
            }
        }
        return false;
    }

    void addCity(City city){
        if(!exist(city)){
            ForecastState forecastState = ForecastState(city: city);
            __savedCities.add(forecastState);
            notifyListeners();

            forecast(forecastState);
            save();
        }
    }

    void remove(int index){
        try{
            ForecastState state = __savedCities.removeAt(index);
            notifyListeners();
            save();

            log("I removed ${state.city.name}");
        }catch(error){
            log("location remove error", error: error);
        }
    }

    void toHome(){
        __toHomeListener();
    }

    void setHomeListener(void Function() homeListener){
        __toHomeListener = homeListener;
    }

    static Future<List<ForecastState>> find() async{
        try{
            ObjectIO objectIO = ObjectIO(folder: "data");
            String savedObject = await objectIO.readFromFile("cities");

            List savedObjsJson = jsonDecode(savedObject) as List;
            return savedObjsJson.map((savedObjJson) =>  ForecastState(city: City.fromJson(savedObjJson))).toList();
        }catch(error){
            log("retrieving saved cities exception:", error: error);
            //throw Exception("encountered an error when retrieving saved cities");
        }
        return [];
    }

    static Future<City?> findLocation() async{
        try{
            ObjectIO objectIO = ObjectIO(folder: "data");
            String savedObject = await objectIO.readFromFile("location");

            dynamic savedObjJson = jsonDecode(savedObject);
            return City.fromJson(savedObjJson);
        }catch(error){
            return Future.error("retrieving saved location exception: $error");
        }
    }

    Future<void> save() async{
        List<City> savedCities = __savedCities.skip(1).map((e) => e.city).toList();
        try{
            ObjectIO objectIO = ObjectIO(folder: "data");
            objectIO.writeToFile("cities", jsonEncode(savedCities));
        }catch(error){
            log("Cities save error:", error: error);
        }
    }

    Future<void> saveLocation(City city) async{
        try{
            ObjectIO objectIO = ObjectIO(folder: "data");
            objectIO.writeToFile("location", jsonEncode(city));
        }catch(error){
            log("Location save error:", error: error);
        }
    }

    Future<void> reload({ bool force = false }) async{
        for (var element in savedCities) {
            if(element.isError || force){
                forecast(element);
            }
        }
    }

    Future<void> reloadCityForecast(ForecastState state) async{
        await forecast(state);
    }

    void setProceedListener(void Function() proceedListener) =>__proceedListener = proceedListener;
}