import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bweatherflutter/components/others.dart';
import 'package:bweatherflutter/providers/settings.dart';
import 'package:bweatherflutter/providers/theme.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class ForecastPage extends StatefulWidget{
    const ForecastPage({super.key});

    @override
    State<StatefulWidget> createState() => ForecastPageState();
}

class ForecastPageState extends State<ForecastPage> with AfterLayoutMixin<ForecastPage>{
    late ThemeNotifier notifier;
    late WeatherNotifer weatherNotifer;
    late SettingsNotifier settingsNotifier;

    @override
    FutureOr<void> afterFirstLayout(BuildContext context) {
        
    }

    @override
    Widget build(BuildContext context) {
        weatherNotifer = Provider.of<WeatherNotifer>(context, listen: true);
        //notifier = Provider.of<ThemeNotifier>(context, listen: true);
        settingsNotifier = Provider.of<SettingsNotifier>(context, listen: true);

        if(weatherNotifer.loading){
            return const Center( child: SizedBox(width: 60, child: LoadingIndicator(indicatorType: Indicator.ballTrianglePathColored, colors: [Colors.orange],)), );
        }

        if(weatherNotifer.isError){
            return const Center(child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Image(image: AssetImage('files/ic_splash.png')),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Text("Encontered an unexpected error, check your internet connection", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300, letterSpacing: 1.4,),),
                )
            ],),);
        }
        
        String currentTime(){
            DateTime init = DateTime.now();
            return "${day(init.weekday)}, ${ init.day } ${ month(init.month) }";
        }

        int current = settingsNotifier.getUnit() == Unit.farighet ? celciustToFahrenheit(weatherNotifer.result["current"]["temp"]) : weatherNotifer.result["current"]["temp"].ceil();
        int like = settingsNotifier.getUnit() == Unit.farighet ? celciustToFahrenheit(weatherNotifer.result["current"]["feels_like"]) : weatherNotifer.result["current"]["feels_like"].ceil();

        String unit = settingsNotifier.getUnit() == Unit.farighet ? "°F" : "℃"; 

        return Column(
            children: [
                Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(top: 8, right: 8), child: IconButton(icon: const Icon(Icons.info_rounded,  size: 32), onPressed: ()=>{  } , color: Colors.deepOrangeAccent),),
                Expanded(
                    child: Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                      children: [
                          Text(weatherNotifer.result["timezone"], style: const TextStyle(color: Colors.blueGrey, fontSize: 26, fontWeight: FontWeight.w300)),
                          Text(currentTime() , style: const TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.w300)),
                          Row(mainAxisSize: MainAxisSize.min,
                              children: [
                                  Text("$current$unit", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w300, color: Colors.orange)),
                                  Image.network("https://openweathermap.org/img/wn/${weatherNotifer.result["current"]["weather"].first["icon"]}@4x.png", height: 110)
                              ],
                          ),
                          Text("feels like $like$unit", style: const TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.w300)),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text("${weatherNotifer.result["current"]["weather"].first["main"]}", style: const TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.w500)),
                          ),
                          Text("${weatherNotifer.result["current"]["weather"].first["description"]}", style: const TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.w300)),
                      ],
                    )),
                ),
                Others( daily: weatherNotifer.result["daily"], hourly: weatherNotifer.result["hourly"], )
          ],
        );
    }
}