import 'package:bweatherflutter/components/cities_tab.dart';
import 'package:bweatherflutter/pages/forcast.dart';
import 'package:bweatherflutter/pages/locations.dart';
import 'package:bweatherflutter/pages/settings.dart';
import 'package:bweatherflutter/states/main_cubit.dart';
import 'package:bweatherflutter/states/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MainScreen extends StatefulWidget {
    static const String routeName = "main";

    const MainScreen({super.key});

    @override
    State<StatefulWidget> createState() => __MainScreenState();
}

class __MainScreenState extends State<MainScreen> {
    bool showSearch = false;

    List<Widget> pages(BuildContext context){
        bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
        bool isTablet = ResponsiveBreakpoints.of(context).isTablet;

        return [
            const ForecastPage(),
            if(isMobile)...[
                Locations(), const Settings()
            ],
            if(isTablet)...[
                const Settings()
            ],
        ];
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        MainCubit mainCubit = context.read<MainCubit>();
        context.read<WeatherCubit>().toHomeListener = ()=> mainCubit.pageIndex = 0;

        return BlocBuilder<MainCubit, MainState>(
            builder: (context, state) =>  Scaffold(
                body: Row(children: [
                    Expanded(child: IndexedStack(index: state.pageIndex, children: pages(context))),
                    if(ResponsiveBreakpoints.of(context).isDesktop) ...[
                        SizedBox(width: 440, child: CitiesTab(showSearch: showSearch, close: ()=> setState(() { showSearch = false; })),)
                    ],
                ]),
                floatingActionButton: Visibility(
                    visible: state.showFAO || (ResponsiveBreakpoints.of(context).isDesktop && !showSearch),
                    child: FloatingActionButton(backgroundColor: theme.secondary,
                        onPressed: () {
                            if(ResponsiveBreakpoints.of(context).isDesktop){
                                setState(() { showSearch = true; });
                            }else{
                                Navigator.pushNamed(context, "cities");
                            }
                        }, //widget.notificationManager.showNotification();
                        child: const Icon(Icons.add_location_alt),
                )),
                bottomNavigationBar: ResponsiveBreakpoints.of(context).isMobile ? NavigationBar(
                    onDestinationSelected: (int index) {
                        mainCubit.pageIndex = index;
                    },
                    selectedIndex: state.pageIndex,
                    destinations: const <Widget>[
                        NavigationDestination(selectedIcon: Icon(Icons.cloud, color: Colors.white,), icon: Icon(Icons.cloud_outlined), label: 'Forecast'),
                        NavigationDestination(selectedIcon: Icon(Icons.map, color: Colors.white), icon: Icon(Icons.map_outlined), label: 'Locations'),
                        NavigationDestination(selectedIcon: Icon(Icons.settings, color: Colors.white,), icon: Icon(Icons.settings_outlined), label: 'Settings'),
                      
                    ],
                ) : null,
            ),
        );
    }
}
