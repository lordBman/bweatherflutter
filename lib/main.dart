import 'package:bweatherflutter/providers/cites.dart';
import 'package:bweatherflutter/providers/main.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/screens/cities.dart';
import 'package:bweatherflutter/screens/info.dart';
import 'package:bweatherflutter/screens/not_found.dart';
import 'package:bweatherflutter/screens/splash.dart';
import 'package:bweatherflutter/screens/test.dart';
import 'package:bweatherflutter/utils/theme.dart';
import 'package:bweatherflutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/settings.dart';
import 'screens/main.dart';

void main() => runApp(const App());

class App extends StatelessWidget{
    const App({ super.key });

    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider(create: (context) => SettingsNotifier(), child: const BWeather());
    }
}

class BWeather extends StatefulWidget {
    const BWeather({super.key});

    @override
    State<BWeather> createState() => __BWeatherState();
}

class __BWeatherState extends State<BWeather> {
    late SettingsNotifier settingsNotifier;

    @override
    Widget build(BuildContext context) {
        TextTheme textTheme = createTextTheme(
            context, "Noto Sans Mono", "Acme");

        MaterialTheme theme = MaterialTheme(textTheme);
        settingsNotifier = context.watch<SettingsNotifier>();

        return MultiProvider(
            providers: [
                ChangeNotifierProvider(create: (context) => CitiesNotifier()),
                ChangeNotifierProvider(create: (context) => MainProvider()),
                ChangeNotifierProvider(create: (context) =>
                    WeatherNotifier(settingsNotifier: settingsNotifier)),
            ],
            child: MaterialApp(title: 'BSoft Weather App',
                debugShowCheckedModeBanner: false,
                theme: theme.light(),
                darkTheme: theme.dark(),
                themeMode: settingsNotifier.themeModeValue,
                initialRoute: Splash.routeName,
                onGenerateRoute: (settings) {
                    return MaterialPageRoute(builder: (context) {
                        switch (settings.name) {
                            case Splash.routeName:
                                return const Splash();
                            case Info.routeName:
                                return const Info();
                            case MainScreen.routeName:
                                return MainScreen();
                            case CitiesScreen.routeName:
                                return const CitiesScreen();
                            default:
                                return const NotFound();
                        }
                    });
                })
        );
    }
}