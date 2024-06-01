import 'package:bweatherflutter/pages/forcast.dart';
import 'package:bweatherflutter/pages/locations.dart';
import 'package:bweatherflutter/pages/settings.dart';
import 'package:bweatherflutter/providers/main.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
    const MainScreen({super.key});

    @override
    State<StatefulWidget> createState() => __MainScreenState();
}

class __MainScreenState extends State<MainScreen> {
    late MainProvider mainProvider;
    late WeatherNotifer weatherNotifer;

    final pages =  [ const ForcastPage(), const Locations(), const Settings()];

    Widget currentPage () =>pages[mainProvider.pageIndex];

    void home(){
        mainProvider.setPage(0);
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        mainProvider = Provider.of<MainProvider>(context, listen: true);
        weatherNotifer = Provider.of<WeatherNotifer>(context, listen: true);
        weatherNotifer.setHomeListener(home);

        /*if(!weatherNotifer.savedCities[0].isError){
            ElegantNotification.info(description:  const Text('This account will be updated once you exit',),).show(context);
        }*/

        return Scaffold(
            body: SafeArea( child: currentPage()), backgroundColor: theme.surface,
            bottomNavigationBar: NavigationBar(
                onDestinationSelected: (int index) => mainProvider.setPage(index),
                selectedIndex: mainProvider.pageIndex, indicatorColor: theme.secondaryFixed,
                destinations: const <Widget>[
                    NavigationDestination(selectedIcon: Icon(Icons.cloud, color: Colors.white), icon: Icon(Icons.cloud_outlined), label: 'Forcast'),
                    NavigationDestination(selectedIcon: Icon(Icons.map, color: Colors.white), icon: Icon(Icons.map_outlined), label: 'Locations'),
                    NavigationDestination(selectedIcon: Icon(Icons.settings, color: Colors.white,), icon: Icon(Icons.settings_outlined), label: 'Settings'),
                  
                ],
            ),
        );
    }
}
