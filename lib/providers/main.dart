import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier{
    int __index = 0;
    int get index => __index;

    int __pageIndex = 0;
    int get pageIndex => __pageIndex;


    void setIndex(int index){
         __index = index;
         __pageIndex = 0;
         notifyListeners();
    }

    void setPage(int index){
        __pageIndex = index;
        notifyListeners();
    }
}