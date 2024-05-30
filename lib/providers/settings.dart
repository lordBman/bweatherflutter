import 'package:bweatherflutter/utils/utils.dart';
import 'package:flutter/material.dart';

class SettingsNotifier extends ChangeNotifier{
    String __unit = "celcius";
    String get unit => __unit;

    int value(double value) => __unit == "farighet" ? celciustToFahrenheit(value) : value.ceil();
    String get unitString => __unit == "farighet" ? "°F" : "℃"; 

    toggleUnit(){
        switch(__unit){
            case "celcius":
                __unit = "farighet";
                break;
            case "farighet":
                __unit = "celcius";
        }
        notifyListeners();
    }

    void setUnit(String unit){
        if(__unit != unit){
            __unit = unit;
            notifyListeners();
        }
    }
}