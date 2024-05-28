import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bweatherflutter/components/error.dart';
import 'package:bweatherflutter/components/loading.dart';
import 'package:bweatherflutter/components/others.dart';
import 'package:bweatherflutter/providers/settings.dart';
import 'package:bweatherflutter/providers/theme.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForecastView extends StatefulWidget{
    final int index;

    const ForecastView({super.key, required this.index});

    @override
    State<StatefulWidget> createState() => __ForecastStatePageState();
}

class __ForecastStatePageState extends State<ForecastView> with AfterLayoutMixin<ForecastView>{
    late ThemeNotifier notifier;
    late WeatherNotifer weatherNotifer;
    late SettingsNotifier settingsNotifier;

    @override
    FutureOr<void> afterFirstLayout(BuildContext context) {
        
    }

    @override
    Widget build(BuildContext context) {
        WeatherNotifer weatherNotifer = Provider.of<WeatherNotifer>(context, listen: true);
        settingsNotifier = Provider.of<SettingsNotifier>(context, listen: true);
        
        ForcastState forecastState = weatherNotifer.savedCities[widget.index];

        if(forecastState.loading){
            return Loading(message: forecastState.message);
        }

        if (forecastState.isError){
            return const ErrorView(message: "Encontered an unexpected error when fetching Forcast, check your internet connection");
        }
        
        String currentTime(){
            DateTime init = DateTime.now();
            return "${day(init.weekday)}, ${ init.day } ${ month(init.month) }";
        }

        int current = settingsNotifier.getUnit() == Unit.farighet ? celciustToFahrenheit(forecastState.result["current"]["temp"]) : forecastState.result["current"]["temp"].ceil();
        int like = settingsNotifier.getUnit() == Unit.farighet ? celciustToFahrenheit(forecastState.result["current"]["feels_like"]) : forecastState.result["current"]["feels_like"].ceil();

        String unit = settingsNotifier.getUnit() == Unit.farighet ? "°F" : "℃";

        return Column(
            children: [
                Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(top: 5, right: 8), 
                    child: IconButton(icon: const Icon(Icons.add_location_alt,  size: 24),
                    onPressed: (){ Navigator.pushNamed(context, "/cities"); },
                    color: Colors.deepOrangeAccent),),
                const SizedBox(height: 15,),
                Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                  children: [
                      Text(forecastState.city.name, style: const TextStyle(color: Colors.blueGrey, fontSize: 36, fontWeight: FontWeight.w300)),
                      Text(forecastState.city.country, style: const TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w300)),
                      const SizedBox(height: 10,),
                      Text(currentTime() , style: const TextStyle(color: Color.fromARGB(255, 19, 28, 33), fontSize: 18, fontWeight: FontWeight.w300)),
                      Row(mainAxisSize: MainAxisSize.min,
                          children: [
                              Text("$current$unit", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w300, color: Colors.orange)),
                              Image.network("https://openweathermap.org/img/wn/${forecastState.result["current"]["weather"].first["icon"]}@4x.png", height: 110)
                          ],
                      ),
                      Text("feels like $like$unit", style: const TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w500)),
                      Text("${forecastState.result["current"]["weather"].first["description"]}", style: const TextStyle(color: Colors.blueGrey, letterSpacing: 1.4, fontSize: 18, fontWeight: FontWeight.w300)),
                  ],
                )),
                const SizedBox(height: 15,),
                Expanded(
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20)),
                            boxShadow: [
                                BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 3, offset: const Offset(0, 2)),
                                const BoxShadow(color: Colors.white, spreadRadius: 0, blurRadius: 0),
                            ]
                        ),
                            
                        child: Center(
                            child: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Others( daily: forecastState.result["daily"], hourly: forecastState.result["hourly"], ),
                            ),
                        ),))
            ],
        );
    }
}