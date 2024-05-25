import 'dart:developer';

import 'package:bweatherflutter/providers/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget{
    final String message;

    const Splash({super.key, this.message = "getting song list, Please wait"});

    @override
    State<StatefulWidget> createState() => __SplashState();
}

class __SplashState extends State<Splash>{
    @override
    Widget build(BuildContext context) {
        SettingsNotifier settingsNotifier = context.watch<SettingsNotifier>();
        settingsNotifier.setProceedListener((){
          Navigator.pushReplacementNamed(context, "/main");
        });
        
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("files/ic_splash.png"),
                SpinKitChasingDots(
                      itemBuilder: (BuildContext buildContext, int index){
                          return DecoratedBox(
                              decoration: BoxDecoration(
                                  color: index.isEven ? Colors.blue : Colors.redAccent,
                                  shape: BoxShape.circle,
                                  boxShadow: const [BoxShadow(blurRadius: 3)])); },
                  ),
                  const SizedBox(height: 20,),
                  Text(widget.message, style: const TextStyle(color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        );
    }
}