import 'package:bweatherflutter/providers/settings.dart';
import 'package:bweatherflutter/utils/result.dart';
import 'package:bweatherflutter/utils/utils.dart';
import 'package:bweatherflutter/utils/weather_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DailyView extends StatefulWidget{
    final Daily daily;
    final DailyUnits units;
    final int index;

    const DailyView({super.key,  required this.daily, required this.units,  required this.index });

    @override
    State<DailyView> createState() => _DailyViewState();
}

class _DailyViewState extends State<DailyView> {
    late SettingsNotifier settingsNotifier;

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        settingsNotifier = Provider.of<SettingsNotifier>(context, listen: true);

        int weatherCode = widget.daily.weather_code[widget.index];
        DateTime time = widget.daily.time[widget.index];
        String tempUnit = widget.units.apparent_temperature_max;

        int min = widget.daily.temperature_2m_min[widget.index].ceil();
        int max = widget.daily.temperature_2m_max[widget.index].ceil();

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