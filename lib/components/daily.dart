import 'package:bweatherflutter/utils/utils.dart';
import 'package:flutter/material.dart';

class DailyView extends StatelessWidget{
    dynamic daily;
    DailyView({ required this.daily });

    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Text(day(DateTime.fromMillisecondsSinceEpoch(daily["dt"] * 1000).weekday), style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),),
                Image.network("https://openweathermap.org/img/wn/${daily["weather"].first["icon"]}@2x.png", height: 100),
                Text("${(daily["temp"]["day"] as double).ceil()}℃", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.blueGrey)),
            ],
        );
    }
}