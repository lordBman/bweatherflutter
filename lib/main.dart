import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/screens/info.dart';
import 'package:bweatherflutter/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/settings.dart';
import 'providers/theme.dart';
import 'screens/main.dart';

void main() => runApp(const BWeather());

class BWeather extends StatelessWidget {
    const BWeather({super.key});

    @override
    Widget build(BuildContext context) {
        return  MultiProvider(
            providers: [
                ChangeNotifierProvider(create: (context) => WeatherNotifer()),
                ChangeNotifierProvider(create: (context) => ThemeNotifier()),
                ChangeNotifierProvider(create: (context) => SettingsNotifier()),
            ],
            child: MaterialApp(
            title: 'BWeather',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
            ),
            routes: {
                "/" : (_)=> const Splash(),
                "/info" : (_)=> const Info(),
                "/main" : (_) => const Main(),
            },
        ));
    }
}