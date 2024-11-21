import 'dart:async';

import 'package:bweatherflutter/components/error.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/screens/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget{
    static const String routeName = "splash";

    const Splash({super.key});

    @override
    State<StatefulWidget> createState() => __SplashState();
}

class __SplashState extends State<Splash>{
    late StreamSubscription<List<ConnectivityResult>> subscription;
    late WeatherNotifier? weatherNotifier;

     @override
    void initState() { 
        super.initState();
        subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
            if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.ethernet)) {
                if(weatherNotifier != null && weatherNotifier!.isError){
                    weatherNotifier?.init();
                }
            }
        });
    }
    
    @override
    Widget build(BuildContext context) {
        weatherNotifier = context.watch<WeatherNotifier>();
        weatherNotifier?.setProceedListener(() {
            weatherNotifier?.initForecast();
            Navigator.pushReplacementNamed(context, MainScreen.routeName);
        });

        return Scaffold(backgroundColor: Colors.white,
            body: SafeArea(
                child: IndexedStack(index: weatherNotifier!.isError ? 1 : 0, children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                        children: [
                            Expanded(child: Center(child: Image.asset("files/splash.jpg", width: 240,))),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  children: [
                                      const SizedBox(width: 40, child: LoadingIndicator(indicatorType: Indicator.ballTrianglePathColored, colors: [Colors.orange],)),
                                      const SizedBox(height: 10,),
                                      Text(weatherNotifier!.message, style: const TextStyle( fontSize: 14, fontWeight: FontWeight.w300, color: Colors.grey),),
                                  ],
                              ),
                            ),
                        ],
                    ),
                    ErrorView(message: weatherNotifier!.message)
                ],),
            ),
        );
    }

    @override
    void dispose() {
        subscription.cancel();
        super.dispose();
    }
}