import 'package:bweatherflutter/components/location.dart';
import 'package:bweatherflutter/states/forecast/weather_state.dart';
import 'package:bweatherflutter/states/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationsView extends StatelessWidget{
    final ScrollController? scrollController;
    final EdgeInsets padding;

    const LocationsView({super.key, this.scrollController, this.padding =  const EdgeInsets.only(top: 20, bottom: 20) });

    @override
    Widget build(BuildContext context) {
        return BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
                return ListView.separated(
                    controller: scrollController,
                    padding: padding,
                    itemCount: state.cities.length + 1,
                    separatorBuilder: (context, index) => const SizedBox(height: 15),
                    itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: LocationItem(index: index - 1),
                    ),
                    //separatorBuilder: (context, index) => const SizedBox(height: 15,),
                );
            }
        );
    }
}