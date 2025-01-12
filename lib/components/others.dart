import 'package:bweather_repository/bweather_repository.dart';
import 'package:bweatherflutter/components/daily.dart';
import 'package:bweatherflutter/components/hourly.dart';
import 'package:bweatherflutter/components/option-button.dart';
import 'package:flutter/material.dart';

class Others extends StatefulWidget{
    final City city;

    const Others({super.key, required this.city });

    @override
    State<StatefulWidget> createState() => __OthersState();
}

class __OthersState extends State<Others>{
    String active = "daily";
    late ColorScheme theme;

    choose(String choice) => setState(()=>active = choice );

    List<Widget> init(Forecast forecast){
        List<Daily> daily = forecast.daily;
        final List<Hourly> hourly = forecast.hourly;
        final length = active == "hourly" ? (hourly.length -  forecast.current.time.hour): daily.length;

        return List.generate(length, (index){
            var child = active == "hourly" ? HourlyView(hourly: hourly[index + forecast.current.time.hour]) : DailyView(daily: daily[index]);
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
                SizedBox(height: 180, child: ListView(scrollDirection: Axis.horizontal, children: init(widget.city.forecast!)))
            ],
        );
    }
}