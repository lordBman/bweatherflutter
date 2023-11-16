import 'package:flutter/material.dart';

class HourlyView extends StatelessWidget{
    dynamic hourly;
    HourlyView({ required this.hourly });

    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Text("${DateTime.fromMillisecondsSinceEpoch(hourly["dt"] * 1000).hour}:00", style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),),
                Image.network("https://openweathermap.org/img/wn/${hourly["weather"].first["icon"]}@2x.png", height: 100),
                Text("${(hourly["temp"] as double).ceil()}℃", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.blueGrey)),
            ],
        );
    }
}