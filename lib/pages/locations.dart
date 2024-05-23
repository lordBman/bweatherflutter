import 'package:bweatherflutter/components/city.dart';
import 'package:bweatherflutter/components/search.dart';
import 'package:bweatherflutter/providers/cites.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/utils/cities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Locations extends StatefulWidget{
    const Locations({super.key});

    @override
    State<StatefulWidget> createState()=> __LocationsState();
}

class __LocationsState extends State<Locations>{
    late WeatherNotifer weatherNotifer;
    late CitiesNotifier citiesNotifier;
    List<City> results = [];
    int index = 0;

    void search(String query){
      setState(() {
          index = 1;
      });

      citiesNotifier.search(query).then((value) {
          setState(() {
              results = value;
              index = 2;
          });
      });
    }
    void cleared(){
        setState(() {
            index = 0;
        });
    }

    @override
    Widget build(BuildContext context) {
        weatherNotifer = Provider.of<WeatherNotifer>(context, listen: true);
        citiesNotifier = Provider.of<CitiesNotifier>(context, listen: true);

        return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Search(onSearch: search, cleared: cleared),
            const SizedBox(height: 10),
            Expanded(
                child: IndexedStack(index: index , children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CityList(),
                    ),
                    const Center(child: Text("Loading"),),
                    ListView.builder(itemCount: results.length, itemBuilder: (context, index)=> CityViewItem(city: results[index]) )
                ],),
            ),
        ],);
    }
}