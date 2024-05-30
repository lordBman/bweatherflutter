import 'package:bweatherflutter/providers/cites.dart';
import 'package:bweatherflutter/providers/main.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/screens/cities.dart';
import 'package:bweatherflutter/screens/info.dart';
import 'package:bweatherflutter/screens/splash.dart';
import 'package:bweatherflutter/utils/theme.dart';
import 'package:bweatherflutter/utils/utils.dart';
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
        final brightness = View.of(context).platformDispatcher.platformBrightness;

        // Retrieves the default theme for the platform
        //TextTheme textTheme = Theme.of(context).textTheme;

        // Use with Google Fonts package to use downloadable fonts
        TextTheme textTheme = createTextTheme(context, "Noto Sans Mono", "Acme");
        
        MaterialTheme theme = MaterialTheme(textTheme);
        
        return  MultiProvider(
            providers: [
                ChangeNotifierProvider(create: (context) => SettingsNotifier()),
                ChangeNotifierProvider(create: (context) => WeatherNotifer()),
                ChangeNotifierProvider(create: (context) => ThemeNotifier()),
                ChangeNotifierProvider(create: (context) => CitiesNotifier())
            ],
            child: MaterialApp(
            title: 'Bsoft Weather App',
            debugShowCheckedModeBanner: false,
            theme: theme.light(),
            darkTheme: theme.dark(),
            themeMode: ThemeMode.light,
            initialRoute: "/splash",
            routes: {
                "/splash" : (_)=> const Splash(),
                "/info" : (_)=> const Info(),
                "/" : (_) => ChangeNotifierProvider(create: (context) => MainProvider(), child: const MainScreen(),),
                "/cities" : (_) => const CitiesScreen(),
            },
        ));
    }
}