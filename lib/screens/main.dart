import 'package:bweatherflutter/pages/forcast.dart';
import 'package:bweatherflutter/pages/locations.dart';
import 'package:bweatherflutter/pages/settings.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
    const Main({super.key});

    @override
    State<StatefulWidget> createState() => __MainState();
}

class __MainState extends State<Main> {
    int __currentPageIndex = 0;

    Widget currentPage () => [ const Forcast(), const Locations(), const Settings()][__currentPageIndex];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: SafeArea( child: currentPage()),
            bottomNavigationBar: NavigationBar(                onDestinationSelected: (int index) {
                    setState(() { __currentPageIndex = index; });
                },
                indicatorColor: Colors.amber[800],
                selectedIndex: __currentPageIndex,
                destinations: const <Widget>[
                    NavigationDestination(selectedIcon: Icon(Icons.cloud), icon: Icon(Icons.cloud_outlined), label: 'Forcast'),
                    NavigationDestination(selectedIcon: Icon(Icons.map), icon: Icon(Icons.map_outlined), label: 'Locations'),
                    NavigationDestination(selectedIcon: Icon(Icons.settings), icon: Icon(Icons.settings_outlined), label: 'Settings'),
                  
                ],
            ),
        );
    }
}
