import 'package:bweatherflutter/utils/connections.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WeatherNotifer extends ChangeNotifier{
    dynamic __result;
    dynamic get result{ return __result; }

    bool __loading = false;
    bool get loading{ return __loading; }

    bool __isError = false;
    bool get isError{ return __isError; }

    dynamic __error;
    dynamic get error{ return __error; }

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

    void load(String city) async{
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
    }

    void init (){
        __loading = true;
        __isError = false;
        __error = "";
        notifyListeners();
        __determinePosition().then((position) async {
            try{ 
                dynamic data = (await Connections().openWeatherAPI.get("/data/3.0/onecall?lat=${position.latitude}&lon=${position.longitude}&exclude=minutely&appid=$apiKey&units=metric")).data;
                __result = data;
                //__error = data;
                __loading = false;//__isError = true;
                notifyListeners();
            }catch(error){
                __loading = false;
                __isError = true; 
                __error = error;
                notifyListeners();
            }
        });
    }

    void setCity(double latitude, double longitude) async{
        __loading = true;
        __isError = false;
        __error = "";
        try{
            dynamic data = (await Connections().openWeatherAPI.get("/data/3.0/onecall?lat=$latitude&lon=$longitude&exclude=minutely&appid=$apiKey&units=metric")).data;
            __result = data;
            //__error = data;
            __loading = false;//__isError = true;
            notifyListeners();
        }catch(error){
            __loading = false;
            __isError = true; 
            __error = error;
            notifyListeners();
        }
    }

    void toHome(){
        __toHomeListener();
    }

    void setHomeListener(void Function() homelistner){
        __toHomeListener = homelistner;
    }
}