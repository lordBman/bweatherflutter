import 'package:bweatherflutter/providers/settings.dart';
import 'package:bweatherflutter/utils/cities.dart';
import 'package:bweatherflutter/utils/result.dart';
import 'package:bweatherflutter/utils/weather_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HourlyView extends StatefulWidget{
    final Hourly hourly;
    final HourlyUnits units;
    final int index;
    final DateTime currentTime;
    final City city;

    const HourlyView({super.key, required this.city, required this.hourly, required this.currentTime, required this.units, required this.index });

  @override
  State<HourlyView> createState() => _HourlyViewState();
}

class _HourlyViewState extends State<HourlyView> {
    late SettingsNotifier settingsNotifier;

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        settingsNotifier = Provider.of<SettingsNotifier>(context, listen: true);

        int weatherCode = widget.hourly.weather_code[widget.index];
        DateTime time = widget.currentTime.add(Duration(hours:  widget.hourly.time[widget.index].hour, minutes: (widget.city.timezone * 60).ceil()));
        int temp = widget.hourly.temperature_2m[widget.index].ceil();
        String tempUnit = widget.units.temperature_2m;

        return Column(
            mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Text("${time.hour}:00", style: TextStyle(color: theme.onSurface, fontWeight: FontWeight.bold),),
                SvgPicture.asset(WeatherCode.decode(code: weatherCode, isNight: time.hour >= 18).image, height: 90, width: 100,),
                Text("$temp$tempUnit", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.blueGrey)),
            ],
        );
    }
}