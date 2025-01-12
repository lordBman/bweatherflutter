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
    late CitiesCubit citiesCubit;
    int index = 0;

    void search(String query){
      citiesCubit.search(query);
      if(query.isNotEmpty && index == 0){
          setState(() {
              index = 1;
          });
      }
    }

    void cleared(){
        setState(() { index = 0; });
    }

    @override
    Widget build(BuildContext context) {
        citiesCubit = context.read<CitiesCubit>();
        return Scaffold(
            body: CustomScrollView(
                slivers: [
                    SliverAppBar(title: const Text("Cities"), titleSpacing: 0, expandedHeight: 110,
                        flexibleSpace: FlexibleSpaceBar(expandedTitleScale: 1,
                            titlePadding: const EdgeInsets.only(left: 50, bottom: 8, right: 8),
                            title: Search(onSearch: search, cleared: cleared),),),
                    SliverFillRemaining(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:  10.0),
                      child: BlocBuilder<CitiesCubit, CitiesState>(
                          builder: (context, state) => IndexedStack(index: index , children: [
                            const CityList(),
                            ListView.separated(
                                itemCount: state.searchResults.length, itemBuilder: (context, index)=> CityViewResultItem(city: state.searchResults[index]),
                                separatorBuilder: (context, index) => const Divider(height: 0.3),
                            )
                        ],),
                      ),
                    ),)
                ],
            ),);
    }
}