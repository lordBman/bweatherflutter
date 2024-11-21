import 'package:bweatherflutter/components/city.dart';
import 'package:bweatherflutter/components/search.dart';
import 'package:bweatherflutter/providers/cites.dart';
import 'package:bweatherflutter/utils/cities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CitiesScreen extends StatefulWidget{
    static const String routeName = "cities";

    const CitiesScreen({super.key});

    @override
    State<StatefulWidget> createState()=> __CitiesScreenState();
}

class __CitiesScreenState extends State<CitiesScreen>{
    late CitiesNotifier citiesNotifier;
    List<City> results = [];
    int index = 0;

    void search(String query){
      citiesNotifier.search(query).then((value) {
          setState(() {
              results = value;
              index = 1;
          });
      });
    }

    void cleared(){
        setState(() { index = 0; });
    }

    @override
    Widget build(BuildContext context) {
        citiesNotifier = context.watch<CitiesNotifier>();
        final ColorScheme theme = Theme.of(context).colorScheme;

        return Scaffold(
            body: CustomScrollView(
                slivers: [
                    SliverAppBar(title: const Text("Cities"), titleSpacing: 0, expandedHeight: 110,
                        flexibleSpace: FlexibleSpaceBar(expandedTitleScale: 1,
                            titlePadding: const EdgeInsets.only(left: 50, bottom: 8, right: 8),
                            title: Search(onSearch: search, cleared: cleared),),),
                    SliverFillRemaining(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:  10.0),
                      child: IndexedStack(index: index , children: [
                          const CityList(),
                          ListView.separated(
                              itemCount: results.length, itemBuilder: (context, index)=> CityViewItem(city: results[index]),
                              separatorBuilder: (context, index) => const Divider(height: 0.3),
                          )
                      ],),
                    ),)
                ],
            ),);
    }
}