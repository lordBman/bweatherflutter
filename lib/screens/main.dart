import 'package:bweatherflutter/pages/forcast.dart';
import 'package:bweatherflutter/pages/locations.dart';
import 'package:bweatherflutter/pages/settings.dart';
import 'package:bweatherflutter/states/main_cubit.dart';
import 'package:bweatherflutter/states/weather_cubit.dart';
import 'package:bweatherflutter/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
    static const String routeName = "main";
    final NotificationManager notificationManager = NotificationManager();

    MainScreen({super.key});

    @override
    State<StatefulWidget> createState() => __MainScreenState();
}

class __MainScreenState extends State<MainScreen> {

    final List<Widget> pages =  [ const ForecastPage(), Locations(), const Settings()];

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        MainCubit mainCubit = context.read<MainCubit>();
        context.read<WeatherCubit>().toHomeListener = ()=> mainCubit.pageIndex = 0;

        return BlocBuilder<MainCubit, MainState>(
            builder: (context, state) =>  Scaffold(
                body: pages[state.pageIndex], //backgroundColor: theme.surface,
                floatingActionButton: Visibility(visible: state.showFAO, child: FloatingActionButton(backgroundColor: theme.secondary,
                    onPressed: () { Navigator.pushNamed(context, "cities"); widget.notificationManager.showNotification(); },
                    child: const Icon(Icons.add_location_alt),
                )),
                bottomNavigationBar: NavigationBar(
                    onDestinationSelected: (int index) => mainCubit.pageIndex = index,
                    selectedIndex: state.pageIndex,
                    destinations: const <Widget>[
                        NavigationDestination(selectedIcon: Icon(Icons.cloud, color: Colors.white,), icon: Icon(Icons.cloud_outlined), label: 'Forecast'),
                        NavigationDestination(selectedIcon: Icon(Icons.map, color: Colors.white), icon: Icon(Icons.map_outlined), label: 'Locations'),
                        NavigationDestination(selectedIcon: Icon(Icons.settings, color: Colors.white,), icon: Icon(Icons.settings_outlined), label: 'Settings'),
                      
                    ],
                ),
            ),
        );
    }
}
