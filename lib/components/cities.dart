import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bweatherflutter/components/city.dart';
import 'package:bweatherflutter/states/cities_cubit.dart';

class CitiesView extends StatelessWidget{
    final int index;

    const CitiesView({super.key, required this.index });

    @override
    Widget build(BuildContext context) {
        return BlocBuilder<CitiesCubit, CitiesState>(
            builder: (context, state) => IndexedStack(index: index , children: [
                const CityList(),
                ListView.separated(
                    itemCount: state.searchResults.length, itemBuilder: (context, index)=> CityViewResultItem(city: state.searchResults[index]),
                    separatorBuilder: (context, index) => const Divider(height: 0.3),
                )
            ]),
        );
    }
}