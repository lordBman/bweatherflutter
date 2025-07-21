import 'package:bweatherflutter/components/cities.dart';
import 'package:bweatherflutter/components/locatiions.dart';
import 'package:bweatherflutter/components/search.dart';
import 'package:bweatherflutter/states/cities_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitiesTab extends StatefulWidget{
    final bool showSearch;
    final void Function()? close;

    const CitiesTab({super.key, this.showSearch = false, this.close });

    @override
    State<StatefulWidget> createState() => __CitiesTabState();
}

class __CitiesTabState extends State<CitiesTab>{
    int index = 0;

    void search(String query){
        if(query.isNotEmpty && index == 0){
            context.read<CitiesCubit>().search(query);
            setState(() { index = 1; });
        }else if(query.isEmpty && index == 1){
            setState(() { index = 0; });
        }
    }

    void cleared() => widget.close?.call();

    @override
    Widget build(BuildContext context) {
        return IndexedStack(index: widget.showSearch ? 1 : 0, children: [
            LocationsView(padding: EdgeInsets.only(top: 50, bottom: 20)),
            Padding(padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                      Search(onSearch: search, cleared: cleared),
                      SizedBox(height: 30),
                      Expanded(child: CitiesView(index: index)),
                  ]),
            ),
        ]);
    }
}