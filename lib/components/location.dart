import 'dart:developer';

import 'package:bweatherflutter/components/clickable.dart';
import 'package:bweatherflutter/components/shimmering/location.dart';
import 'package:bweatherflutter/providers/main.dart';
import 'package:bweatherflutter/providers/settings.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/utils/result.dart';
import 'package:bweatherflutter/utils/utils.dart';
import 'package:bweatherflutter/utils/weather_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LocationItem extends StatefulWidget{
    final int index;

    const LocationItem({ super.key, required this.index });

    @override
    State<StatefulWidget> createState() => __LocationItemState();
}

class __LocationItemState extends State<LocationItem>{
    late WeatherNotifier weatherNotifier;
    late SettingsNotifier settingsNotifier;
    late MainProvider mainProvider;
    late ColorScheme theme;

    void remove() => weatherNotifier.remove(widget.index);

    @override
    Widget build(BuildContext context) {
        theme = Theme.of(context).colorScheme;
        mainProvider = context.watch<MainProvider>();
        weatherNotifier = context.watch<WeatherNotifier>();
        settingsNotifier = context.watch<SettingsNotifier>();

        if(weatherNotifier.savedCities[widget.index].loading){
            return const LocationItemShimmering();
        }

        ForecastState state = weatherNotifier.savedCities[widget.index];
        String temperature = "--", unit = "", time = "--:--";
        int code = 0;
        bool isNight = false;
        if(state.result != null){
            Current current = state.result!.current;

            temperature = "${current.temperature_2m.ceil()}";
            unit = state.result!.current_units.temperature_2m;

            DateTime initTime = current.time.add(Duration(minutes: (state.city.timezone * 60).ceil()));
            time = formatTime(time: initTime, timezone: state.city.timezone.ceil());
            code = current.weather_code;
            isNight = current.is_day == 0;
        }

        return Clickable(clicked: (){ mainProvider.index = widget.index; },
          child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: theme.surfaceContainerHigh,
                  /*boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 2)),
                  ]*/
              ),
              child: Column(children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      SvgPicture.asset(WeatherCode.decode(code: code, isNight: isNight).image, width: 100, height: 100),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(
                              children: [
                                  Expanded(child: Text(state.city.name, maxLines: 1, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: theme.primary))),
                                  Visibility(visible: widget.index != 0, child: Container(alignment: Alignment.centerRight,
                                      child: IconButton(style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)), icon: const Icon(Icons.cancel_outlined), color: theme.error, onPressed: remove),)),
                              ],
                            ),
                            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text(WeatherCode.decode(code: code, isNight: isNight).description, style: GoogleFonts.aBeeZee(fontSize: 16, fontWeight: FontWeight.w600, color: theme.onSurface)),
                                      Text(time, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: theme.onSurface))
                                  ],),
                                ),
                                Text("$temperature°", style: GoogleFonts.fuzzyBubbles(fontSize: 46, letterSpacing: 1.4, fontWeight: FontWeight.w200, color: theme.primary))
                            ],)
                        ],),
                      ),
                  ],),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [0, 1, 2, 3, 4].map((index){
                      if(state.result != null){
                          temperature = state.result!.hourly.temperature_2m[index].ceil().toString();
                          unit = state.result!.hourly_units.temperature_2m;

                          DateTime initTime = state.result!.hourly.time[index].add(Duration(minutes: (state.city.timezone * 60).ceil()));
                          time = "${initTime.hour}:00";
                          code = state.result!.hourly.weather_code[index];
                          isNight = state.result!.hourly.time[index].hour > 18 || state.result!.hourly.time[index].hour < 6;
                      }

                      return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          SvgPicture.asset(WeatherCode.decode(code: code, isNight: isNight).image, height: 60),
                          Text("$temperature$unit", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.primary)),
                          Text(time, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: theme.onSurface)),
                      ],);
                  }).toList(),)
              ],)
          ),
        );
    }
}