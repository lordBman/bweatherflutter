import 'package:bweatherflutter/providers/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget{
    const Settings({super.key});

    @override
  State<StatefulWidget> createState() => __SettingsState();
}

class __SettingsState extends State<Settings>{
    late SettingsNotifier __settingsNotifier;

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        __settingsNotifier = Provider.of<SettingsNotifier>(context, listen: true);

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Icon(Icons.settings_applications_outlined, size: 32),
                        SizedBox(width: 10,),
                        Text("Settings", style: TextStyle(color: Colors.grey, fontSize: 24),),
                    ],
                ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text("General", style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 16, fontWeight: FontWeight.w600),),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DecoratedBox(
                  decoration: BoxDecoration(color: theme.secondaryContainer, borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: Padding(padding: const EdgeInsets.all(8),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text("Select Scale", style: TextStyle(color: theme.secondary, fontSize: 16, fontWeight: FontWeight.w500),),
                        ListTile(selectedColor: theme.secondary,
                            title: const Text('Celcius(℃)'), horizontalTitleGap: 0,
                            leading: Radio<String>(value: "celcius", groupValue:  __settingsNotifier.unit,
                                onChanged: (String? value) { __settingsNotifier.setUnit(value!); },
                            ) ,
                        ),
                        ListTile(selectedColor: theme.secondary,
                            title: const Text('Fahrenheit(°F)'), horizontalTitleGap: 0,
                            leading: Radio<String>(value: "farighet", groupValue:  __settingsNotifier.unit,
                                onChanged: (String? value) { __settingsNotifier.setUnit(value!); },)
                        )
                      ],),
                  ),
              ),
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(top: 12, left: 20),
              child: Text("About", style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 16, fontWeight: FontWeight.w600),),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: const Padding(padding: EdgeInsets.all(8),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Bsoft Weather is developed and maintained by Nobel owned by Bsoft", style: TextStyle(fontSize: 16, letterSpacing: 1.4, fontWeight: FontWeight.w300),),
                          SizedBox(height: 10),
                          Text("Weather data source: OpenWeatherman API", style: TextStyle(fontWeight: FontWeight.w500),),
                      ])
                  )
              )
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(top: 12, left: 20),
              child: Text("Version", style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 16, fontWeight: FontWeight.w600),),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 6, left: 20),
              child: Text("1.0.0", style: TextStyle(color: Colors.grey, fontSize: 14, letterSpacing: 1.4, fontWeight: FontWeight.w300)),
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(top: 12, left: 20),
              child: Text("Privacy Policy", style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 16, fontWeight: FontWeight.w600),),
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(top: 12, left: 20),
              child: Text("Terms and Condition", style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 16, fontWeight: FontWeight.w600),),
            ),
        ],);
    }
}