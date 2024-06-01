import 'package:bweatherflutter/providers/main.dart';
import 'package:bweatherflutter/providers/settings.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationItem extends StatefulWidget{
    final int index;

    const LocationItem({ super.key, required this.index });

    @override
    State<StatefulWidget> createState() => __LocationItemState();
}

class __LocationItemState extends State<LocationItem>{
    late WeatherNotifer weatherNotifer;
    late SettingsNotifier settingsNotifier;
    late MainProvider mainProvider;
    late ColorScheme theme;

    List<Widget> init(ForcastState state){
        List<Widget> init = [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(state.city.name, style: TextStyle(fontSize: 20, letterSpacing: 1.4, fontWeight: FontWeight.w300, color: theme.primary),),
                const SizedBox(height: 4,),
                Text(state.city.country, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: theme.onSurfaceVariant),),
            ],)
        ];

        if(!state.loading && !state.isError){
            int current = settingsNotifier.value(state.result["current"]["temp"]);
            init.add(
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Text("$current${settingsNotifier.unitString}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: theme.primaryFixed)),
                    Image.network("https://openweathermap.org/img/wn/${state.result["current"]["weather"].first["icon"]}@4x.png", height: 60),
                ],)
            );
        }
        return init;
    }

    void remove() => weatherNotifer.remove(widget.index);

    @override
    Widget build(BuildContext context) {
        theme = Theme.of(context).colorScheme;
        mainProvider = Provider.of<MainProvider>(context, listen: true);
        weatherNotifer = Provider.of<WeatherNotifer>(context, listen: true);
        settingsNotifier = Provider.of<SettingsNotifier>(context, listen: true);

        ForcastState state = weatherNotifer.savedCities[widget.index];

        if(widget.index == 0){
            return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: init(state)),
            );            
        }

        return TextButton(onPressed: ()=> mainProvider.setIndex(widget.index),
            child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Expanded(
                      child: DecoratedBox(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: theme.surfaceContainerLowest , boxShadow: const [
                              BoxShadow(color: Colors.grey, offset: Offset(0.6,0.6), blurRadius: 1.4, spreadRadius: 0.8), 
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: init(state)),
                          )
                      ),
                  ),
                  IconButton(onPressed: remove, icon: Icon(Icons.cancel_outlined, color: theme.error,), padding: const EdgeInsets.all(0),),
              ],
            ),
        );
    }
}