import 'package:bweatherflutter/providers/settings.dart';
import 'package:bweatherflutter/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget{
    const Settings({super.key});

    @override
  State<StatefulWidget> createState() => __SettingsState();
}

class __SettingsState extends State<Settings>{
    late SettingsNotifier __settingsNotifier;
    late ThemeNotifier notifier;

    @override
    Widget build(BuildContext context) {
        __settingsNotifier = Provider.of<SettingsNotifier>(context, listen: true);
        notifier = Provider.of<ThemeNotifier>(context, listen: true);

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text("Settings", style: TextStyle(color: Colors.grey, fontSize: 20),),
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(top: 12, left: 12),
              child: Text("General", style: TextStyle(color: Colors.orange, fontSize: 16),),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: Padding(padding: const EdgeInsets.all(8),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const Text("Select Scale", style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),),
                        ListTile(
                            title: const Text('Celcius(C)'), horizontalTitleGap: 0,
                            leading: Radio<Unit>(value: Unit.celcius, groupValue:  __settingsNotifier.getUnit(),
                                onChanged: (Unit? value) { __settingsNotifier.setUnit(value!); },
                            ) ,
                        ),
                        ListTile(
                            title: const Text('Farighet(F)'), horizontalTitleGap: 0,
                            leading: Radio<Unit>(value: Unit.farighet, groupValue:  __settingsNotifier.getUnit(),
                                onChanged: (Unit? value) { __settingsNotifier.setUnit(value!); },)
                        )
                      ],),
                  ),
              ),
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(top: 12, left: 12),
              child: Text("About", style: TextStyle(color: Colors.orange, fontSize: 16),),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: const Padding(padding: EdgeInsets.all(8),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Bsoft Weather is developed and maintained by Nobel owned by Bsoft", style: TextStyle(fontSize: 14, letterSpacing: 1.4, fontWeight: FontWeight.w300),),
                          SizedBox(height: 10),
                          Text("Weather data source: Weatherman API", style: TextStyle(fontWeight: FontWeight.w500),),
                      ])
                  )
              )
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(top: 12, left: 12),
              child: Text("Version", style: TextStyle(color: Colors.orange, fontSize: 16),),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 6, left: 12),
              child: Text("1.0.0", style: TextStyle(color: Colors.grey, fontSize: 14, letterSpacing: 1.4, fontWeight: FontWeight.w300)),
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(top: 12, left: 12),
              child: Text("Privacy Policy", style: TextStyle(color: Colors.orange, fontSize: 16),),
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(top: 12, left: 12),
              child: Text("Terms and Condition", style: TextStyle(color: Colors.orange, fontSize: 16),),
            ),
        ],);
    }
}