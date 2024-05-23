import 'package:bweatherflutter/utils/cities.dart';
import 'package:flutter/material.dart';


class CitiesNotifier extends ChangeNotifier{
     Map<int, String> letters = {};

    CitiesNotifier(){
        init().then((value) {
            letters = value;
            notifyListeners();
        });
    }

    Future<void> test() async{}

    Future<List<City>> search(String query) async{
        List<City> init = [];

        for (var element in cities) { 
          if(element.name.toLowerCase().contains(query)){
              init.add(element);
          }
        }
        return init;
    }

    Future<Map<int, String>> init() async {
        List<MapEntry<int, String>> entries = [];

        cities.sort((City a, City b)=> a.name.compareTo(b.name));
        
        String last = "";
        for (int index = 0; index < cities.length; index++) {
            City city = cities[index];
            String letter = city.name.characters.first.toUpperCase();
            if(last != letter){
                entries.add(MapEntry(index, letter));
                last = letter;
            }
        }
        return Map<int, String>.fromEntries(entries);
    }
}