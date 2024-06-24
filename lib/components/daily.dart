import 'package:bweatherflutter/providers/settings.dart';
import 'package:bweatherflutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyView extends StatefulWidget{
    final dynamic daily;
    
    const DailyView({super.key,  required this.daily });

    @override
    State<DailyView> createState() => _DailyViewState();
}

class _DailyViewState extends State<DailyView> {
    late SettingsNotifier settingsNotifier;

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        settingsNotifier = Provider.of<SettingsNotifier>(context, listen: true);

        int current = settingsNotifier.value(widget.daily["temp"]["day"]);

        return Column(
            mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Text(day(DateTime.fromMillisecondsSinceEpoch(widget.daily["dt"] * 1000).weekday), style: TextStyle(color: theme.onSurface, fontWeight: FontWeight.w400),),
                Image.network("https://openweathermap.org/img/wn/${widget.daily["weather"].first["icon"]}@2x.png", height: 90, width: 100,),
                Text("$current${settingsNotifier.unitString}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.blueGrey)),
            ],
        );
    }
}