import 'package:bweatherflutter/pages/forcast.dart';
import 'package:bweatherflutter/pages/locations.dart';
import 'package:bweatherflutter/pages/settings.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
    const MainScreen({super.key});

    @override
    State<StatefulWidget> createState() => __MainScreenState();
}

class __MainScreenState extends State<MainScreen> {
    int __currentPageIndex = 0;
    late WeatherNotifer weatherNotifer;

    Widget currentPage () => [ const ForecastPage(), const Locations(), const Settings()][__currentPageIndex];

    void home(){
        setState(() {
            __currentPageIndex = 0;
        });
    }

    @override
    Widget build(BuildContext context) {
        weatherNotifer = Provider.of<WeatherNotifer>(context, listen: true);
        weatherNotifer.setHomeListener(home);
        return Scaffold(
            body: SafeArea( child: currentPage()),
            bottomNavigationBar: NavigationBar(
                onDestinationSelected: (int index) {
                    setState(() { __currentPageIndex = index; });
                },
                indicatorColor: Colors.deepOrangeAccent,
                selectedIndex: __currentPageIndex,
                destinations: const <Widget>[
                    NavigationDestination(selectedIcon: Icon(Icons.cloud, color: Colors.white), icon: Icon(Icons.cloud_outlined), label: 'Forcast'),
                    NavigationDestination(selectedIcon: Icon(Icons.map, color: Colors.white), icon: Icon(Icons.map_outlined), label: 'Locations'),
                    NavigationDestination(selectedIcon: Icon(Icons.settings, color: Colors.white,), icon: Icon(Icons.settings_outlined), label: 'Settings'),
                  
                ],
            ),
        );
    }
}
