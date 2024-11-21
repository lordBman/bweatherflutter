import 'dart:async';

import 'package:bweatherflutter/components/error.dart';
import 'package:bweatherflutter/components/forcast.dart';
import 'package:bweatherflutter/providers/main.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ForecastPage extends StatefulWidget{
    const ForecastPage({ super.key });

    @override
    State<StatefulWidget> createState()=> __ForecastPage();
}

class __ForecastPage extends State<ForecastPage>{
    late WeatherNotifier weatherNotifier;
    late MainProvider mainProvider;
    late StreamSubscription<List<ConnectivityResult>> subscription;

    @override
    void initState() {
        super.initState();
        subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
            if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.ethernet)) {
                weatherNotifier.reload();
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        weatherNotifier = context.watch<WeatherNotifier>();
        mainProvider = context.watch<MainProvider>();
        /*mainProvider.indexListener = (index){
            pageController.animateToPage(index, duration: const Duration(seconds: 2), curve: Curves.easeOutCirc);
        };*/

        /*if(weatherNotifier.loading){
            return Loading(message: weatherNotifier.message);
        }*/

        if(weatherNotifier.isError){
            return const ErrorView(message: "Encountered an unexpected error, check your internet connection");
        }

        return PageView.builder(
            controller: PageController(initialPage: mainProvider.index),
            itemBuilder: (context, index) => ForecastView(index: index),
            itemCount: weatherNotifier.savedCities.length,);
    }
}