import 'dart:async';
import 'dart:developer';

import 'package:bweatherflutter/utils/cities.dart';
import 'package:bweatherflutter/utils/connections.dart';
import 'package:bweatherflutter/utils/objectio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

class ForcastState{
    City city;
    dynamic result;
    bool loading = true;
    bool isError = false;
    String message;
    dynamic error;

    ForcastState({ required this.city, this.message = "" });
}

class WeatherNotifer extends ChangeNotifier{
    bool __loading = true, __isError = false, __proceeded = false;
    bool get loading=> __loading;
    bool get isError=> __isError;

    String __message = "Getting user current loaction";
    String get message=> __message;

    dynamic __error;
    dynamic get error => __error;

    final List<ForcastState> __savedCities = [];
    List<ForcastState> get savedCities => __savedCities;

    late void Function() __toHomeListener;
    late void Function() __proceedListener;

    City? __location;
    City? get location => __location;

    WeatherNotifer(){
        __message = "Checking for saved loaction";
        notifyListeners();
        findLoaction().then((location)=> __location = location).whenComplete((){
            if(location != null){
                __savedCities.add(ForcastState(city: __location!));

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

    /*void load(String city) async{
        __loading = true; __isError = false; __error = "";
        notifyListeners();
        try{
            dynamic location = (await Connections().openWeatherAPI.get("/geo/1.0/direct?q=$city&limit=1&appid=$apiKey")).data;
            __result = (await Connections().openWeatherAPI.get("/data/3.0/onecall?lat=${location[0].lat}&lon=${location[0].lon}&appid=$apiKey&units=metric")).data;
            
            __loading = false;
            notifyListeners();
        }catch(error){
            __loading = false;
            __isError = true; 
            __error = error;
            notifyListeners();
        }
    }*/

    Future<void> forcast(ForcastState savedCity) async{
        savedCity.message = "Getting weather forcast for ${savedCity.city.name}";
        savedCity.loading = true;
        savedCity.isError = false;
        notifyListeners();

        try{
            savedCity.result = (await Connections().openWeatherAPI.get("/data/3.0/onecall?lat=${savedCity.city.latitude}&lon=${savedCity.city.longitude}&exclude=minutely&appid=$apiKey&units=metric")).data;
            savedCity.loading = false;
        }catch(error){
            savedCity.isError = true;
            savedCity.error = error; 
        }
        savedCity.loading = false;
        notifyListeners();
    }

    void init (){
        __message = "Getting user current loaction";
        __isError = false;
        __loading = true;
        notifyListeners();

        __determinePosition().then((position){
            if(position != null){
                placemarkFromCoordinates(position.latitude, position.longitude).then((placemarks){
                    City city = City(name: placemarks[0].locality!, country: placemarks[0].country!, latitude: position.latitude, longitude: position.longitude);
                    if(__location != null && __location?.country != city.country && __location?.name != city.name){
                        __savedCities.removeAt(0);
                        __savedCities.insert(0, ForcastState(city: city));
                    }else if(__location == null){
                        __savedCities.insert(0, ForcastState(city: city));
                    }
                    __location = city;
                    saveLocation(city);          
                }).onError((error, strace){
                    __isError = true; 
                    __error = error;
                    __message = "Encontered an unexpected error, check your internet connection";
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

    void initForcast(){
        if(!__isError){
            for (var savedCity in __savedCities) { 
                forcast(savedCity);
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
        ForcastState forcastState = ForcastState(city: city);
        if(!exist(city)){
            __savedCities.add(forcastState);
            notifyListeners();

            forcast(forcastState);
            save();
        }
    }

    void remove(int index){
        __savedCities.removeAt(index);
        notifyListeners();

        save();
    }

    void toHome(){
        __toHomeListener();
    }

    void setHomeListener(void Function() homelistner){
        __toHomeListener = homelistner;
    }

    static Future<List<ForcastState>> find() async{
        try{
            ObjectIO objectIO = ObjectIO(folder: "data");
            String savedObject = await objectIO.readFromFile("cities");

            List savedObjsJson = jsonDecode(savedObject) as List;
            return savedObjsJson.map((savedObjJson) =>  ForcastState(city: City.fromJson(savedObjJson))).toList();
        }catch(error){
            log("retrieving saved cities exception:", error: error);
            //throw Exception("encountered an error when retrieving saved cities");
        }
        return [];
    }

    static Future<City?> findLoaction() async{
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
            log("CIties save error:", error: error);
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

    void reload(){
        for (var element in savedCities) {
            if(element.isError){
                forcast(element);
            }
        }
    }

    void setProceedListener(void Function() proceedListner) =>__proceedListener = proceedListner;
}