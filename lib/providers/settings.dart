import 'package:flutter/material.dart';
enum Unit{
  celcius,
  farighet
}

class SettingsNotifier extends ChangeNotifier{
    Unit __unit = Unit.celcius;
    //late void Function() __proceedListener;

    Unit getUnit()=> __unit;

    toggleUnit(){
        switch(__unit){
            case Unit.celcius:
                __unit = Unit.farighet;
                break;
            case Unit.farighet:
                __unit = Unit.celcius;
        }
        notifyListeners();
    }

    void setUnit(Unit unit){
        if(__unit != unit){
            __unit = unit;
            notifyListeners();
        }
    }
}