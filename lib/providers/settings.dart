import 'dart:convert';
import 'dart:developer';

import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/utils/objectio.dart';
import 'package:flutter/material.dart';

enum TempUnit{ fahrenheit, celsius }
extension TempUnitExtension on TempUnit{
    String serialize(){
        switch(this){
            case TempUnit.fahrenheit:
                return "fahrenheit";
            case TempUnit.celsius:
                return "celsius";
        }
    }
}
TempUnit tempUnitFromString(String data){
    switch(data){
        case "fahrenheit":
            return TempUnit.fahrenheit;
        default:
            return TempUnit.celsius;
    }
}

enum WindSpeedUnit { ms, mph, kmh }
extension WindSpeedUnitExtension on WindSpeedUnit{
    String serialize(){
        switch(this){
            case WindSpeedUnit.ms:
                return "ms";
            case WindSpeedUnit.mph:
                return "mph";
            case WindSpeedUnit.kmh:
                return "kmh";
        }
    }
}
WindSpeedUnit windSpeedUnitFromString(String data){
    switch(data){
        case "ms":
            return WindSpeedUnit.ms;
        case "mph":
            return WindSpeedUnit.mph;
        default:
            return WindSpeedUnit.kmh;
    }
}

enum PrecipitationUnit{ inch, mm }
extension PrecipitationUnitExtension on PrecipitationUnit{
    String serialize(){
        switch(this){
            case PrecipitationUnit.inch:
                return "inch";
            case PrecipitationUnit.mm:
                return "mm";
        }
    }
}
PrecipitationUnit precipitationUnitFromString(String data){
    switch(data){
        case "inch":
            return PrecipitationUnit.inch;
        default:
            return PrecipitationUnit.mm;
    }
}

class SettingsData {
    TempUnit temp_unit;
    WindSpeedUnit wind_speed_unit;
    PrecipitationUnit precipitation_unit;

    String themeMode;

    SettingsData({
        this.temp_unit = TempUnit.celsius, this.wind_speed_unit = WindSpeedUnit.ms,
        this.precipitation_unit = PrecipitationUnit.mm, this.themeMode = "auto"
    });

    factory SettingsData.fromJson(dynamic json) {
        return SettingsData(
            temp_unit: tempUnitFromString(json["temp_unit"].toString()),
            wind_speed_unit: windSpeedUnitFromString(json["wind_speed_unit"].toString()),
            precipitation_unit: precipitationUnitFromString(json["precipitation_unit"].toString()),
            themeMode: json["themeMode"].toString());
    }

    Map toJson() => {
        "temp_unit" : temp_unit.serialize(), "wind_speed_unit": wind_speed_unit.serialize(),
        "precipitation_unit": precipitation_unit.serialize(), "themeMode" : themeMode
    };

    String serialize() => jsonEncode(toJson());
}

class SettingsNotifier extends ChangeNotifier{
    SettingsData __settings = SettingsData();

    String get themeMode => __settings.themeMode;
    set themeMode(String mode){
        if(__settings.themeMode != mode){
            __settings.themeMode = mode;
            notifyListeners();
            __save();
        }
    }
    ThemeMode get themeModeValue{
        switch(__settings.themeMode){
            case "light":
                return ThemeMode.light;
            case "dark":
                return ThemeMode.dark;
        }
        return ThemeMode.system;
    }

    TempUnit get tempUnit => __settings.temp_unit;
    set tempUnit(TempUnit unit){
        if(__settings.temp_unit != unit){
            __settings.temp_unit = unit;
            notifyListeners();
            __save(reload: true);
        }
    }

    WindSpeedUnit get windSpeedUnit => __settings.wind_speed_unit;
    set windSpeedUnit (WindSpeedUnit unit){
        if(__settings.wind_speed_unit != unit){
            __settings.wind_speed_unit = unit;
            notifyListeners();
            __save(reload: true);
        }
    }

    PrecipitationUnit get precipitationUnit => __settings.precipitation_unit;
    set precipitationUnit(PrecipitationUnit unit){
        if(__settings.precipitation_unit != unit){
            __settings.precipitation_unit = unit;
            notifyListeners();
            __save(reload: true);
        }
    }

    WeatherNotifier? __weatherNotifier;
    set weatherNotifier(WeatherNotifier weatherNotifier){
        __weatherNotifier = weatherNotifier;
    }

    SettingsNotifier(){
        __find().then((value){
            __settings = value;
            notifyListeners();
        });
    }

    Future<SettingsData> __find() async{
        try{
            ObjectIO objectIO = ObjectIO(folder: "data");
            String savedObject = await objectIO.readFromFile("settings");

            return SettingsData.fromJson(jsonDecode(savedObject));
        }catch(error){
            log("retrieving saved setting exception:", error: error);
            //throw Exception("encountered an error when retrieving saved settings");
        }
        return SettingsData();
    }

    Future<void> __save({ bool reload = false}) async{
        if(reload && __weatherNotifier != null){
            __weatherNotifier?.reload(force: true);
        }
        try{
            ObjectIO objectIO = ObjectIO(folder: "data");
            objectIO.writeToFile("settings", jsonEncode(__settings));
        }catch(error){
            log("Settings save error:", error: error);
        }
    }
}