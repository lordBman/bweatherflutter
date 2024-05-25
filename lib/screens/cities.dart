import 'package:bweatherflutter/components/city.dart';
import 'package:bweatherflutter/components/search.dart';
import 'package:bweatherflutter/providers/cites.dart';
import 'package:bweatherflutter/utils/cities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CitiesScreen extends StatefulWidget{
    const CitiesScreen({super.key});

    @override
    State<StatefulWidget> createState()=> __CitiesScreenState();
}

class __CitiesScreenState extends State<CitiesScreen>{
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
        citiesNotifier = Provider.of<CitiesNotifier>(context, listen: true);

        void back() => Navigator.pop(context);

        return Scaffold(
            body: SafeArea( child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
                children: [
                    IconButton(onPressed: back, icon: const Icon(Icons.arrow_back)),
                    const SizedBox(width: 4,),
                    Expanded(child: Search(onSearch: search, cleared: cleared)),
                ],
            ),
            const SizedBox(height: 10),
            Expanded(
                child: IndexedStack(index: index , children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CityList(),
                    ),
                    const Center(child: Text("Loading"),),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.separated(
                        itemCount: results.length, itemBuilder: (context, index)=> CityViewItem(city: results[index]),
                        separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.blueGrey,),
                      ),
                    )
                ],),
            ),
        ],)),);
    }
}