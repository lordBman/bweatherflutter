import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bweatherflutter/components/others.dart';
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

    @override
    FutureOr<void> afterFirstLayout(BuildContext context) {
        
    }

    @override
    Widget build(BuildContext context) {
        weatherNotifer = Provider.of<WeatherNotifer>(context, listen: true);
        notifier = Provider.of<ThemeNotifier>(context, listen: true);
        if(weatherNotifer.loading){
            return const Center( child: SizedBox(width: 60, child: LoadingIndicator(indicatorType: Indicator.ballTrianglePathColored, colors: [Colors.orange],)), );
        }

        if(weatherNotifer.isError){
            return Text(weatherNotifer.error.toString());
        }
        
        String currentTime(){
            DateTime init = DateTime.now();
            return "${day(init.weekday)}, ${ init.day } ${ month(init.month) }";
        }

        return Column(
            children: [
                Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(top: 8, right: 8), child: IconButton(icon: Icon(Icons.info_rounded,  size: 32), onPressed: ()=>{  } , color: Colors.deepOrangeAccent),),
                Expanded(
                    child: Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                      children: [
                          Text(weatherNotifer.result["timezone"], style: const TextStyle(color: Colors.blueGrey, fontSize: 26, fontWeight: FontWeight.w300)),
                          Text(currentTime() , style: const TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.w300)),
                          Row(mainAxisSize: MainAxisSize.min,
                              children: [
                                  Text("${(weatherNotifer.result["current"]["temp"]).ceil()}℃", 
                                      style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w300, color: Colors.orange)),
                                  Image.network("https://openweathermap.org/img/wn/${weatherNotifer.result["current"]["weather"].first["icon"]}@4x.png", height: 110)
                              ],
                          ),
                          Text("feels like ${(weatherNotifer.result["current"]["feels_like"]).ceil()}℃", 
                              style: const TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.w300)),
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