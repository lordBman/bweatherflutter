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

    List<Widget> init(ForcastState state){
        List<Widget> init = [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(state.city.name, style: const TextStyle(fontSize: 20, letterSpacing: 1.4, fontWeight: FontWeight.w300, color: Colors.deepOrangeAccent),),
                const SizedBox(height: 4,),
                Text(state.city.country, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),),
            ],)
        ];

        if(!state.loading && !state.isError){
            int current = settingsNotifier.getUnit() == Unit.farighet ? celciustToFahrenheit(state.result["current"]["temp"]) : state.result["current"]["temp"].ceil();
            String unit = settingsNotifier.getUnit() == Unit.farighet ? "°F" : "℃";
            init.add(
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Text("$current$unit", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.orange)),
                    Image.network("https://openweathermap.org/img/wn/${state.result["current"]["weather"].first["icon"]}@4x.png", height: 60),
                ],)
            );
        }
        return init;
    }

    void remove() => weatherNotifer.remove(widget.index);

    @override
    Widget build(BuildContext context) {
        weatherNotifer = Provider.of<WeatherNotifer>(context, listen: true);
        settingsNotifier = Provider.of<SettingsNotifier>(context, listen: true);

        ForcastState state = weatherNotifer.savedCities[widget.index];

        if(widget.index == 0){
            return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: init(state)),
            );            
        }

        return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Expanded(
                      child: DecoratedBox(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), boxShadow: const [
                              BoxShadow(color: Colors.grey, offset: Offset(1.0,1.0), blurRadius: 3.0, spreadRadius: 1.2),
                              BoxShadow(color: Colors.white, offset: Offset(0.0, 0.0), blurRadius: 0.0, spreadRadius: 0.0), 
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: init(state)),
                          )
                      ),
                  ),
                  IconButton(onPressed: remove, icon: const Icon(Icons.cancel_outlined), padding: const EdgeInsets.all(0),),
              ],
            ),
        );
    }
}