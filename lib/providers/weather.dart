import 'dart:developer';

import 'package:bweatherflutter/utils/cities.dart';
import 'package:bweatherflutter/utils/connections.dart';
import 'package:bweatherflutter/utils/objectio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:convert';

class ForcastState{
    City city;
    dynamic result;
    bool loading = true;
    bool isError = false;
    dynamic error;

    ForcastState({ required this.city });
}

class WeatherNotifer extends ChangeNotifier{
    bool __loading = true;
    bool get loading{ return __loading; }

    bool __isError = false;
    bool get isError{ return __isError; }

    dynamic __error;
    dynamic get error{ return __error; }

    final List<ForcastState> __savedCities = [];
    List<ForcastState> get savedCities{ return __savedCities; }

    late void Function() __toHomeListener;

    WeatherNotifer(){
        init();
    }

    Future<Position> __determinePosition() async {
        bool serviceEnabled;
        LocationPermission permission;

        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
            return Future.error('Location services are disabled.');
        }

        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied) {
                return Future.error('Location permissions are denied');
            }
        }
      
        if (permission == LocationPermission.deniedForever) {
            return Future.error('Location permissions are permanently denied, we cannot request permissions.');
        }
        return await Geolocator.getCurrentPosition();
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

    Future<void> init () async{
        try{
            Position position = await __determinePosition();
            List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
            
            City city = City(name: placemarks[0].locality!, country: placemarks[0].country!, latitude: position.latitude, longitude: position.longitude);
            __savedCities.insert(0, ForcastState(city: city));

            List<ForcastState> saved = await find();
            __savedCities.addAll(saved);
        }catch(error){
            __isError = true; 
            __error = error;
        }

        __loading = false;
        notifyListeners();

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

    Future<void> save() async{
        List<City> savedCities = __savedCities.skip(1).map((e) => e.city).toList();
        try{
            ObjectIO objectIO = ObjectIO(folder: "data");
            objectIO.writeToFile("cities", jsonEncode(savedCities));
        }catch(error){
            log("CIties save error:", error: error);
        }
    }

    void reload(){
        if(isError){
            init();
        }else{
            for (var element in savedCities) {
                if(element.isError){
                    forcast(element);
                }
            }
        }
    }
}