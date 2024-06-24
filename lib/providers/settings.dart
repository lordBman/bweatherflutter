import 'dart:convert';
import 'dart:developer';

import 'package:bweatherflutter/utils/objectio.dart';
import 'package:bweatherflutter/utils/utils.dart';
import 'package:flutter/material.dart';

class Settings {
    String unit;

    String themeMode;

    Settings({ this.unit = "celcius", this.themeMode = "auto" });

    factory Settings.fromJson(dynamic json) {
        return Settings(unit: json["unit"] as String, themeMode: json["themeMode"] as String);
    }

    Map toJson() => { "unit" : unit, "themeMode" : themeMode };

    String serialize() => jsonEncode(toJson());
}

class SettingsNotifier extends ChangeNotifier{
    Settings __settings = Settings();
    String get unit => __settings.unit;

    String get themeMode => __settings.themeMode;
    ThemeMode get themeModeValue{
        switch(__settings.themeMode){
            case "light":
                return ThemeMode.light;
            case "dark":
                return ThemeMode.dark;
        }
        return ThemeMode.system;
    }

    int value(double value) => __settings.unit == "farighet" ? celciustToFahrenheit(value) : value.ceil();
    String get unitString => __settings.unit == "farighet" ? "°F" : "℃";

    SettingsNotifier(){
        find().then((value){
            __settings = value;
            notifyListeners();
        });
    }

    toggleUnit(){
        switch(__settings.unit){
            case "celcius":
                __settings.unit = "farighet";
                break;
            case "farighet":
                __settings.unit = "celcius";
        }
        notifyListeners();
        save();
    }

    void setUnit(String unit){
        if(__settings.unit != unit){
            __settings.unit = unit;
            notifyListeners();
            save();
        }
    }

    void setThemeMode(String mode){
        if(__settings.themeMode != mode){
            __settings.themeMode = mode;
            notifyListeners();
            save();
        }
    }

    static Future<Settings> find() async{
        try{
            ObjectIO objectIO = ObjectIO(folder: "data");
            String savedObject = await objectIO.readFromFile("settings");

            return Settings.fromJson(jsonDecode(savedObject));
        }catch(error){
            log("retrieving saved setting exception:", error: error);
            //throw Exception("encountered an error when retrieving saved settings");
        }
        return Settings();
    }

    Future<void> save() async{
        try{
            ObjectIO objectIO = ObjectIO(folder: "data");
            objectIO.writeToFile("settings", jsonEncode(__settings));
        }catch(error){
            log("Settings save error:", error: error);
        }
    }
}