import 'package:bweather_repository/bweather_repository.dart';
import 'package:bweatherflutter/utils/weather_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HourlyView extends StatefulWidget{
    final Hourly hourly;

    const HourlyView({super.key, required this.hourly });

  @override
  State<HourlyView> createState() => _HourlyViewState();
}

class _HourlyViewState extends State<HourlyView> {

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        int weatherCode = widget.hourly.weather_code;
        int temp = widget.hourly.temperature.value.ceil();
        String tempUnit = widget.hourly.temperature.unit;

        return Column(
            mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Text("${widget.hourly.time.hour}:00", style: TextStyle(color: theme.onSurface, fontWeight: FontWeight.bold),),
                SvgPicture.asset(WeatherCode.decode(code: weatherCode, isNight: widget.hourly.time.hour >= 18).image, height: 90, width: 100,),
                Text("$temp$tempUnit", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.blueGrey)),
            ],
        );
    }
}