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
            var child = active == "hourly" ? HourlyView(hourly: widget.hourly[index]) : DailyView(daily: widget.daily[index]);
            init.add(Padding(
                padding: const EdgeInsets.all(8.0),
                child: DecoratedBox( decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 3, offset: const Offset(0, 2)),
                        const BoxShadow(color: Colors.white, spreadRadius: 0, blurRadius: 0),
                    ]
                ), child: child,)),
            );
            index += 1;
        }
        
        return init;
    }

    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end,
            children: [
                Option(onChoose: choose),
                const SizedBox(height: 12,),
                SizedBox(height: 180, child: ListView(scrollDirection: Axis.horizontal, children: init()))
            ],
        );
    }
}