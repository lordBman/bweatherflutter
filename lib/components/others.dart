import 'package:bweatherflutter/components/daily.dart';
import 'package:bweatherflutter/components/hourly.dart';
import 'package:bweatherflutter/components/option-button.dart';
import 'package:flutter/material.dart';

class Others extends StatefulWidget{
    final List<dynamic> daily;
    final List<dynamic> hourly;

    const Others({super.key, required this.daily, required this.hourly });

    @override
    State<StatefulWidget> createState() => __OthersState();
}

class __OthersState extends State<Others>{
    String active = "daily";

    choose(String chioce) => setState(()=>active = chioce );

    List<Widget> init(){
        List<Widget> init = [];
        int index = 1;
        while(init.length < 6){
            init.add(Padding(
                padding: const EdgeInsets.all(8.0),
                child: active == "hourly" ? HourlyView(hourly: widget.hourly[index]) : DailyView(daily: widget.daily[index]),
            ));
            index += 1;
        }
        return init;
    }

    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end,
            children: [
                Option(onChoose: choose),
                Wrap(children: init()),
            ],
        );
    }
}