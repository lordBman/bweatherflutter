import 'package:bweatherflutter/pages/forcast.dart';
import 'package:bweatherflutter/pages/locations.dart';
import 'package:bweatherflutter/pages/settings.dart';
import 'package:bweatherflutter/providers/main.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
    static const String routeName = "main";
    final NotificationManager notificationManager = NotificationManager();

    MainScreen({super.key});

    @override
    State<StatefulWidget> createState() => __MainScreenState();
}

class __MainScreenState extends State<MainScreen> {
    late MainProvider mainProvider;
    late WeatherNotifier weatherNotifier;

    final List<Widget> pages =  [ const ForecastPage(), Locations(), const Settings()];

    void home() => mainProvider.pageIndex = 0;

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        mainProvider = Provider.of<MainProvider>(context, listen: true);
        weatherNotifier = Provider.of<WeatherNotifier>(context, listen: true);
        weatherNotifier.setHomeListener(home);

        return Scaffold(
            body: pages[mainProvider.pageIndex], //backgroundColor: theme.surface,
            floatingActionButton: Visibility(visible: mainProvider.showFAO, child: FloatingActionButton(backgroundColor: theme.secondary,
                onPressed: () { Navigator.pushNamed(context, "cities"); widget.notificationManager.showNotification(); },
                child: const Icon(Icons.add_location_alt),
            )),
            bottomNavigationBar: NavigationBar(
                onDestinationSelected: (int index) => mainProvider.pageIndex = index,
                selectedIndex: mainProvider.pageIndex,
                destinations: const <Widget>[
                    NavigationDestination(selectedIcon: Icon(Icons.cloud, color: Colors.white,), icon: Icon(Icons.cloud_outlined), label: 'Forecast'),
                    NavigationDestination(selectedIcon: Icon(Icons.map, color: Colors.white), icon: Icon(Icons.map_outlined), label: 'Locations'),
                    NavigationDestination(selectedIcon: Icon(Icons.settings, color: Colors.white,), icon: Icon(Icons.settings_outlined), label: 'Settings'),
                  
                ],
            ),
        );
    }
}
