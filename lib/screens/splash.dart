import 'dart:async';

import 'package:bweatherflutter/components/error.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget{
    const Splash({super.key});

    @override
    State<StatefulWidget> createState() => __SplashState();
}

class __SplashState extends State<Splash>{
    late StreamSubscription<List<ConnectivityResult>> subscription;
    late WeatherNotifer weatherNotifer;

     @override
    void initState() { 
        super.initState();
        subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
            if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.ethernet)) {
                if(weatherNotifer != null && weatherNotifer.isError){
                    weatherNotifer.init();
                }
            }
        });
    }
    
    @override
    Widget build(BuildContext context) {
        weatherNotifer = Provider.of<WeatherNotifer>(context, listen: true);
        /*SettingsNotifier settingsNotifier = context.watch<SettingsNotifier>();
        settingsNotifier.setProceedListener((){
          
        });*/

        weatherNotifer.setProceedListener(() {
            weatherNotifer.initForcast();
            Navigator.pushReplacementNamed(context, "/");
        });

        Widget view(){
            if(weatherNotifer.isError){
                return ErrorView(message: weatherNotifer.message);
            }

            return Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                children: [
                    Expanded(child: Center(child: Image.asset("files/splash.jpg", width: 260,))),
                    Column(
                        children: [
                            const SizedBox(width: 50, child: LoadingIndicator(indicatorType: Indicator.ballTrianglePathColored, colors: [Colors.orange],)),
                            const SizedBox(height: 10,),
                            Text(weatherNotifer.message, style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w300),),
                        ],
                    ),
                ],
            );
        }
        
        return Scaffold(
            body: Container( color: Colors.white10, child: view()),
        );
    }

    @override
    void dispose() {
        subscription.cancel();
        super.dispose();
    }
}