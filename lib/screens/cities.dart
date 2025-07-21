import 'package:bweatherflutter/components/cities.dart';
import 'package:bweatherflutter/components/city.dart';
import 'package:bweatherflutter/components/search.dart';
import 'package:bweatherflutter/states/cities_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitiesScreen extends StatefulWidget{
    static const String routeName = "cities";

    const CitiesScreen({super.key});

    @override
    State<StatefulWidget> createState()=> __CitiesScreenState();
}

class __CitiesScreenState extends State<CitiesScreen>{
    int index = 0;

    void search(String query){
        if(query.isNotEmpty && index == 0){
            context.read<CitiesCubit>().search(query);
            setState(() {
                index = 1;
            });
        }
    }

    void cleared() => setState(() { index = 0; });

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: CustomScrollView(
                slivers: [
                    SliverAppBar(title: const Text("Cities"), titleSpacing: 0, expandedHeight: 110,
                        flexibleSpace: FlexibleSpaceBar(expandedTitleScale: 1,
                            titlePadding: const EdgeInsets.only(left: 50, bottom: 8, right: 8),
                            title: Search(onSearch: search, cleared: cleared),),),
                    SliverFillRemaining(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:  10.0),
                      child: CitiesView(index: index)
                    ),)
                ],
            ),);
    }
}