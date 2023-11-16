import 'package:bweatherflutter/utils/connections.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:json_annotation/json_annotation.dart';
part 'weather.g.dart';

@JsonSerializable()
class Weather{
    int id;
    String main;
    String description;
    String icon;

    Weather(this.id, this.main, this.description, this.icon);

    factory Weather.fromJson(Map<String, dynamic> json)=> _$WeatherFromJson(json);

    Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Current{
    int dt;
    int sunrise;
    int sunset;
    double temp;
    double feels_like;
    int pressure;
    int humidity;
    double dew_point;
    double uvi;
    int clouds;
    int visibility;
    double wind_speed;
    int wind_deg;
    double wind_gust;
    List<Weather> weather;

    Current(
      this.dt, this.sunrise, this.sunset, this.clouds, this.dew_point, this.feels_like, this.humidity, this.pressure, this.temp, this.uvi,
      this.visibility, this.weather, this.wind_deg, this.wind_gust, this.wind_speed);

    factory Current.fromJson(Map<String, dynamic> json)=> _$CurrentFromJson(json);

    Map<String, dynamic> toJson() => _$CurrentToJson(this);
}

@JsonSerializable()
class Hourly{
    int dt;
    double temp;
    double feels_like;
    int pressure;
    int humidity;
    double dew_point;
    double uvi;
    int clouds;
    int visibility;
    double wind_speed;
    int wind_deg;
    double wind_gust;
    List<Weather> weather;
    double pop;

    Hourly(
        this.dt, this.clouds, this.dew_point, this.feels_like, this.humidity, this.pop, this.pressure, this.temp, this.uvi, this.visibility, 
        this.weather, this.wind_deg, this.wind_gust,  this.wind_speed
    );

    factory Hourly.fromJson(Map<String, dynamic> json)=> _$HourlyFromJson(json);

    Map<String, dynamic> toJson() => _$HourlyToJson(this);
}

@JsonSerializable()
class Temp{
    double day;
    double min;
    double max;
    double night;
    double eve;
    double morn;

    Temp(this.day, this.eve, this.max, this.min, this.morn, this.night);

    factory Temp.fromJson(Map<String, dynamic> json)=> _$TempFromJson(json);

    Map<String, dynamic> toJson() => _$TempToJson(this);
}

@JsonSerializable()
class FeelsLike{
    double day;
    double night;
    double eve;
    double morn;

    FeelsLike( this.day, this.eve, this.morn, this.night);

    factory FeelsLike.fromJson(Map<String, dynamic> json)=> _$FeelsLikeFromJson(json);

    Map<String, dynamic> toJson() => _$FeelsLikeToJson(this);
}

@JsonSerializable()
class Daily{
    int dt;
    int sunrise;
    int sunset;
    int moonrise;
    int moonset;
    double moon_phase;
    String summary;
    Temp temp;
    FeelsLike feels_like;
    int pressure;
    int humidity;
    double dew_point;
    double wind_speed;
    int wind_deg;
    double wind_gust;
    List<Weather> weather;
    int clouds;
    double pop;
    double rain;
    double uvi;

    Daily(
        this.clouds, this.dew_point, this.dt, this.feels_like, this.humidity, this.moon_phase,
        this.moonrise, this.moonset, this.pop, this.pressure, this.rain, this.summary, this.uvi,
        this.sunrise, this.sunset, this.temp, this.weather, this.wind_deg,this.wind_gust, this.wind_speed
    );

    factory Daily.fromJson(Map<String, dynamic> json)=> _$DailyFromJson(json);

    Map<String, dynamic> toJson() => _$DailyToJson(this);
}

@JsonSerializable()
class Data{
    double lat;
    double lon;
    String timezone;
    int timezone_offset;
    Current current;
    List<Hourly> hourly;
    List<Daily> daily;

    Data(this.current, this.daily, this.hourly, this.lat, this.lon, this.timezone, this.timezone_offset);

    factory Data.fromJson(Map<String, dynamic> json)=> _$DataFromJson(json);

    Map<String, dynamic> toJson() => _$DataToJson(this);
}

class WeatherNotifer extends ChangeNotifier{
    dynamic __result;
    dynamic get result{ return __result; }

    bool __loading = false;
    bool get loading{ return __loading; }

    bool __isError = false;
    bool get isError{ return __isError; }

    dynamic __error;
    dynamic get error{ return __error; }

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
}