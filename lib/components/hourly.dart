import 'package:bweatherflutter/providers/settings.dart';
import 'package:bweatherflutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HourlyView extends StatefulWidget{
    dynamic hourly;

    HourlyView({super.key,  required this.hourly });

  @override
  State<HourlyView> createState() => _HourlyViewState();
}

class _HourlyViewState extends State<HourlyView> {
    late SettingsNotifier settingsNotifier;

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        settingsNotifier = Provider.of<SettingsNotifier>(context, listen: true);

        int current = settingsNotifier.value(widget.hourly["temp"]);
        return Column(
            mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Text("${DateTime.fromMillisecondsSinceEpoch(widget.hourly["dt"] * 1000).hour}:00", style: TextStyle(color: theme.onSurface, fontWeight: FontWeight.w400),),
                Image.network("https://openweathermap.org/img/wn/${widget.hourly["weather"].first["icon"]}@2x.png", height: 90, width: 100,),
                Text("$current${settingsNotifier.unitString}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.blueGrey)),
            ],
        );
    }
}