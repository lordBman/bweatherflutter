import 'dart:async';

import 'package:bweatherflutter/components/error.dart';
import 'package:bweatherflutter/components/forcast.dart';
import 'package:bweatherflutter/states/forecast/weather_state.dart';
import 'package:bweatherflutter/states/main_cubit.dart';
import 'package:bweatherflutter/states/weather_cubit.dart';
import 'package:bweatherflutter/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ForecastPage extends StatefulWidget{
    const ForecastPage({ super.key });

    @override
    State<StatefulWidget> createState()=> __ForecastPage();
}

class __ForecastPage extends State<ForecastPage>{
    late WeatherCubit weatherCubit;
    late StreamSubscription<List<ConnectivityResult>> subscription;

    @override
    void initState() {
        super.initState();
        subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
            if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.ethernet)) {
                weatherCubit.reload();
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        weatherCubit = context.read<WeatherCubit>();
        /*mainProvider.indexListener = (index){
            pageController.animateToPage(index, duration: const Duration(seconds: 2), curve: Curves.easeOutCirc);
        };*/

        /*if(weatherNotifier.loading){
            return Loading(message: weatherNotifier.message);
        }*/

        return BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state){
            if(state.status.isFailure){
                return const ErrorView(message: "Encountered an unexpected error, check your internet connection");
            }

            return BlocBuilder<MainCubit, MainState>(
                builder: (context, mainState) {
                    return PageView.builder(
                        controller: PageController(initialPage: mainState.index),
                        itemBuilder: (context, index) => ForecastView(index: index),
                        itemCount: state.cities.length,);
                }
            );
        });
    }
}