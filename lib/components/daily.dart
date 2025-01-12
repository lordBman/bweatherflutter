import 'package:bweather_repository/bweather_repository.dart';
import 'package:bweatherflutter/utils/utils.dart';
import 'package:bweatherflutter/utils/weather_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DailyView extends StatefulWidget{
    final Daily daily;

    const DailyView({super.key,  required this.daily });

    @override
    State<DailyView> createState() => _DailyViewState();
}

class _DailyViewState extends State<DailyView> {

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        int weatherCode = widget.daily.weather_code;
        DateTime time = widget.daily.time;
        String tempUnit = widget.daily.apparent_temperature_max.unit;

        int min = widget.daily.temperature_min.value.ceil();
        int max = widget.daily.temperature_max.value.ceil();

        return Column(
            mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Text(day(time.weekday), style: TextStyle(color: theme.onSurface, fontWeight: FontWeight.bold),),
                SvgPicture.asset(WeatherCode.decode(code: weatherCode, isNight: false).image, width: 100, height: 90),
                Text("$min-$max$tempUnit", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.blueGrey)),
            ],
        );
    }
}