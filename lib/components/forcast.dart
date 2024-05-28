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
import 'package:flutter_svg/flutter_svg.dart';
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

        int current = settingsNotifier.getUnit() == Unit.farighet ? celciustToFahrenheit(forecastState.result["current"]["temp"] as double) : forecastState.result["current"]["temp"].ceil();
        //int like = settingsNotifier.getUnit() == Unit.farighet ? celciustToFahrenheit(forecastState.result["current"]["feels_like"]) : forecastState.result["current"]["feels_like"].ceil();

        String unit = settingsNotifier.getUnit() == Unit.farighet ? "°F" : "℃";

        return Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(top: 5, right: 8), 
                    child: IconButton(icon: const Icon(Icons.add_location_alt,  size: 28),
                    onPressed: (){ Navigator.pushNamed(context, "/cities"); },
                    color: Colors.deepOrangeAccent),),
                const SizedBox(height: 15,),
                Expanded(
                    child: Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                      children: [
                          Text(forecastState.city.name, style: const TextStyle(color: Colors.blueGrey, fontSize: 36, fontWeight: FontWeight.w300)),
                          Text(forecastState.city.country, style: const TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w300)),
                          const SizedBox(height: 10,),
                          Text(currentTime() , style: const TextStyle(color: Color.fromARGB(255, 19, 28, 33), fontSize: 18, fontWeight: FontWeight.w300)),
                          Row(mainAxisSize: MainAxisSize.min,
                              children: [
                                  Text("$current$unit", style: const TextStyle(fontSize: 85, fontWeight: FontWeight.w300, color: Colors.orange)),
                                  Image.network("https://openweathermap.org/img/wn/${forecastState.result["current"]["weather"].first["icon"]}@4x.png", height: 140)
                              ],
                          ),
                          //Text("feels like $like$unit", style: const TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w500)),
                          Text("${forecastState.result["current"]["weather"].first["description"]}", style: const TextStyle(color: Colors.blueGrey, letterSpacing: 1.4, fontSize: 22, fontWeight: FontWeight.w300)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Row(
                                        children: [
                                            SvgPicture.asset("files/cloud-bolt-rain.svg", width: 30, colorFilter: const ColorFilter.mode( Colors.blueGrey, BlendMode.srcIn),),
                                            const SizedBox(width: 8,),
                                            Text("${forecastState.result["current"]["clouds"]}%", style: const TextStyle(fontSize: 22, color: Colors.blueGrey),),
                                        ],
                                    ),
                                    const SizedBox(height: 8,),
                                    const Text("Chance of Rain", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),)
                                ],),
                                const SizedBox(height: 50, child: VerticalDivider(color: Colors.blueGrey, thickness: 2,)),
                                Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Row(
                                        children: [
                                            SvgPicture.asset("files/leaf.svg", width: 30, colorFilter: const ColorFilter.mode( Colors.blueGrey, BlendMode.srcIn),),
                                            const SizedBox(width: 8,),
                                            Text("${forecastState.result["current"]["wind_speed"]} \u33A7", style: const TextStyle(fontSize: 22, color: Colors.blueGrey),),
                                        ],
                                    ),
                                    const SizedBox(height: 8,),
                                    const Text("Wind Speed", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),)
                                ],),
                                const SizedBox(height: 50, child: VerticalDivider(color: Colors.blueGrey, thickness: 2,)),
                                Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Row(
                                        children: [
                                            const Icon(Icons.water_drop_outlined, color: Colors.blueGrey, size: 32,),
                                            const SizedBox(width: 8,),
                                            Text("${forecastState.result["current"]["humidity"]}%", style: const TextStyle(fontSize: 22, color: Colors.blueGrey),),
                                        ],
                                    ),
                                    const SizedBox(height: 8,),
                                    const Text("Humidity", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),)
                                ],)
                            ],),
                          )
                      ],
                    )),
                ),
                const SizedBox(height: 15,),
                Others( daily: forecastState.result["daily"], hourly: forecastState.result["hourly"], )
            ],
        );
    }
}