import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
    const Splash({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: SafeArea(child: Center(
                child: Image.asset("files/ic_splash.png", width: 300,),
            )),
        );
    }
}
