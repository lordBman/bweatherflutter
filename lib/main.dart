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
import 'screens/main.dart';

void main() => runApp(const App());

class App extends StatelessWidget{
    const App({ super.key });

    @override
    Widget build(BuildContext context) {
        return MultiProvider(
            providers: [
                ChangeNotifierProvider(create: (context)=> SettingsNotifier()),
                ChangeNotifierProvider(create: (context) => WeatherNotifer()),
                ChangeNotifierProvider(create: (context) => CitiesNotifier())
            ], child: const BWeather());
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
        //final brightness = View.of(context).platformDispatcher.platformBrightness;

        // Retrieves the default theme for the platform
        //TextTheme textTheme = Theme.of(context).textTheme;

        // Use with Google Fonts package to use downloadable fonts
        TextTheme textTheme = createTextTheme(context, "Noto Sans Mono", "Acme");
        
        MaterialTheme theme = MaterialTheme(textTheme);
        settingsNotifier = Provider.of<SettingsNotifier>(context, listen: true);
        return  MaterialApp( title: 'Bsoft Weather App', debugShowCheckedModeBanner: false,
            theme: theme.lightMediumContrast(), darkTheme: theme.dark(),
            themeMode: settingsNotifier.themeModeValue,
            initialRoute: "/splash",
            routes: {
                "/splash" : (_)=> const Splash(),
                "/info" : (_)=> const Info(),
                "/" : (_) => ChangeNotifierProvider(create: (context) => MainProvider(), child: const MainScreen(),),
                "/cities" : (_) => const CitiesScreen(),
            },
        );
    }
}