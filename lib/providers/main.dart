import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier{
    int __index = 0;
    int get index => __index;
    set index(int index){
      __index = index;
      pageIndex = 0;
      __showFAO = false;
      notifyListeners();
    }

    int __pageIndex = 0;
    int get pageIndex => __pageIndex;
    set pageIndex(int index){
      __pageIndex = index;
      __showFAO = index == 1;
      notifyListeners();
    }

    bool __showFAO = true;
    bool get showFAO => __showFAO && __pageIndex == 1;
    set showFAO(bool value){
        if(__showFAO != value){
            __showFAO = value;
            notifyListeners();
        }
    }
}