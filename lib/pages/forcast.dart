import 'dart:async';

import 'package:bweatherflutter/components/forcast.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ForcastPage extends StatefulWidget{
    @override
    State<StatefulWidget> createState()=> __ForcastPage();
}

class __ForcastPage extends State<ForcastPage>{
    late WeatherNotifer weatherNotifer;
    late StreamSubscription<List<ConnectivityResult>> subscription;

    Future<void> refresh() => weatherNotifer.init();

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

        if(weatherNotifer.loading){
            return const Center( child: SizedBox(width: 60, child: LoadingIndicator(indicatorType: Indicator.ballTrianglePathColored, colors: [Colors.orange],)), );
        }

        return Swiper(
            loop: false,
            itemBuilder: (context, index){ return LiquidPullToRefresh(
                onRefresh: refresh,
                showChildOpacityTransition: true,
                child: ForecastView(index: index)); 
            },
            itemCount: weatherNotifer.savedCities.length,);
    }

    @override
  void dispose() {
      subscription.cancel();
      super.dispose();
  }
}