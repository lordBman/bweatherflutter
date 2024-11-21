import 'package:bweatherflutter/components/daily.dart';
import 'package:bweatherflutter/components/hourly.dart';
import 'package:bweatherflutter/components/option-button.dart';
import 'package:bweatherflutter/utils/cities.dart';
import 'package:bweatherflutter/utils/result.dart';
import 'package:flutter/material.dart';

class Others extends StatefulWidget{
    final Result result;
    final City city;

    const Others({super.key, required this.result, required this.city });

    @override
    State<StatefulWidget> createState() => __OthersState();
}

class __OthersState extends State<Others>{
    String active = "daily";
    late ColorScheme theme;

    choose(String choice) => setState(()=>active = choice );

    List<Widget> init(){
        Daily daily = widget.result.daily;
        final DailyUnits dailyUnits = widget.result.daily_units;
        final Hourly hourly = widget.result.hourly;
        final HourlyUnits hourlyUnits = widget.result.hourly_units;
        final length = active == "hourly" ? hourly.time.length : daily.time.length;

        return List.generate(length, (index){
            var child = active == "hourly" ? HourlyView(city: widget.city, hourly: hourly, units: hourlyUnits, currentTime: widget.result.current.time, index: index) : DailyView(daily: daily, units: dailyUnits, index: index);
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: DecoratedBox( decoration: BoxDecoration(color: theme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(10),
                    /*boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 2)),
                    ]*/
                ), child: child,));
        });
    }

    @override
    Widget build(BuildContext context) {
        theme = Theme.of(context).colorScheme;

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