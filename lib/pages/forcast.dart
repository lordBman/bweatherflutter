import 'dart:async';

import 'package:bweatherflutter/components/error.dart';
import 'package:bweatherflutter/components/forcast.dart';
import 'package:bweatherflutter/components/loading.dart';
import 'package:bweatherflutter/providers/main.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ForcastPage extends StatefulWidget{
    const ForcastPage({ super.key });

    @override
    State<StatefulWidget> createState()=> __ForcastPage();
}

class __ForcastPage extends State<ForcastPage>{
    late WeatherNotifer weatherNotifer;
    late MainProvider mainProvider;
    late StreamSubscription<List<ConnectivityResult>> subscription;

    Future<void> refresh() async => weatherNotifer.reload();

    @override
    void initState() {
        super.initState();
        subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
            if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.ethernet)) {
                weatherNotifer.reload();
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        weatherNotifer = Provider.of<WeatherNotifer>(context, listen: true);
        mainProvider = Provider.of<MainProvider>(context, listen: true);

        /*if(weatherNotifer.loading){
            return Loading(message: weatherNotifer.message);
        }*/

        if(weatherNotifer.isError){
            return const ErrorView(message: "Encontered an unexpected error, check your internet connection");
        }

        return Swiper(
            loop: false, index: mainProvider.index,
            indicatorLayout:PageIndicatorLayout.DROP,
            itemBuilder: (context, index){ return LiquidPullToRefresh(
                onRefresh: refresh,
                showChildOpacityTransition: true,
                child: ForecastView(index: index)); 
            },
            itemCount: weatherNotifer.savedCities.length,);
    }
}