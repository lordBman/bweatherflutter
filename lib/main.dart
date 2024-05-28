import 'package:bweatherflutter/providers/cites.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/screens/cities.dart';
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
                ChangeNotifierProvider(create: (context) => SettingsNotifier()),
                ChangeNotifierProvider(create: (context) => WeatherNotifer()),
                ChangeNotifierProvider(create: (context) => ThemeNotifier()),
                ChangeNotifierProvider(create: (context) => CitiesNotifier()),
            ],
            child: MaterialApp(
            title: 'Bsoft Weather App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
                useMaterial3: true,
            ),
            initialRoute: "/splash",
            routes: {
                "/splash" : (_)=> const Splash(),
                "/info" : (_)=> const Info(),
                "/" : (_) => const MainScreen(),
                "/cities" : (_) => const CitiesScreen(),
            },
        ));
    }
}