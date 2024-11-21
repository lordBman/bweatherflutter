import 'package:bweatherflutter/providers/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

        return CustomScrollView(
            slivers: [
                SliverAppBar(pinned: true,
                    leading: const Icon(Icons.settings_outlined),
                    title: Text("Settings", style: TextStyle(color: theme.onSurface))),
                SliverToBoxAdapter(child: Scrollbar(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: Text("General", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: theme.surfaceContainerHighest, borderRadius: const BorderRadius.all(Radius.circular(10))),
                              child: Padding(padding: const EdgeInsets.all(10),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Theme", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w500),),
                                      Row(children: [
                                          Radio<String>(value: "auto", groupValue:  __settingsNotifier.themeMode,
                                              onChanged: (String? value) => __settingsNotifier.themeMode = value!,
                                          ),
                                          const Text('Auto')
                                      ]),
                                      Row(children: [
                                          Radio<String>(value: "light", groupValue:  __settingsNotifier.themeMode,
                                              onChanged: (String? value) => __settingsNotifier.themeMode = value!),
                                          const Text("Light Mode"),
                                      ]),
                                      Row(children: [
                                          Radio<String>(value: "dark", groupValue:  __settingsNotifier.themeMode,
                                              onChanged: (String? value) => __settingsNotifier.themeMode = value!),
                                          const Text('Dark Mode'),
                                      ])
                                  ],),
                              ),
                          ),
                      ),
                      Padding(
                          padding:  const EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: theme.surfaceContainerHighest, borderRadius: const BorderRadius.all(Radius.circular(10))),
                              child: Padding(padding: const EdgeInsets.all(8),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Select Temperature Scale", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w500),),
                                      Row(children: [
                                          Radio<TempUnit>(value: TempUnit.celsius, groupValue:  __settingsNotifier.tempUnit,
                                              onChanged: (TempUnit? value) => __settingsNotifier.tempUnit = value!),
                                          const Text('Celsius(℃)')
                                      ]),
                                      Row(children: [
                                          Radio<TempUnit>(value: TempUnit.fahrenheit, groupValue:  __settingsNotifier.tempUnit,
                                              onChanged: (TempUnit? value) => __settingsNotifier.tempUnit = value!),
                                          const Text('Fahrenheit(°F)'),
                                      ])
                                  ],),
                              ),
                          ),
                      ),
                      Padding(
                          padding:  const EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: theme.surfaceContainerHighest, borderRadius: const BorderRadius.all(Radius.circular(10))),
                              child: Padding(padding: const EdgeInsets.all(8),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Select Wind Speed Scale", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w500),),
                                      Row(children: [
                                          Radio<WindSpeedUnit>(value: WindSpeedUnit.kmh, groupValue:  __settingsNotifier.windSpeedUnit,
                                              onChanged: (WindSpeedUnit? value) => __settingsNotifier.windSpeedUnit = value!),
                                          const Text('Kilometer per hour')
                                      ]),
                                      Row(children: [
                                          Radio<WindSpeedUnit>(value: WindSpeedUnit.mph, groupValue:  __settingsNotifier.windSpeedUnit,
                                              onChanged: (WindSpeedUnit? value) => __settingsNotifier.windSpeedUnit = value!),
                                          const Text('meter per hour'),
                                      ]),
                                      Row(children: [
                                          Radio<WindSpeedUnit>(value: WindSpeedUnit.ms, groupValue:  __settingsNotifier.windSpeedUnit,
                                              onChanged: (WindSpeedUnit? value) => __settingsNotifier.windSpeedUnit = value!),
                                          const Text('meter per second'),
                                      ])
                                  ],),
                              ),
                          ),
                      ),
                      Padding(
                          padding:  const EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: theme.surfaceContainerHighest, borderRadius: const BorderRadius.all(Radius.circular(10))),
                              child: Padding(padding: const EdgeInsets.all(8),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Select Precipitation Scale", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w500),),
                                      Row(children: [
                                          Radio<PrecipitationUnit>(value: PrecipitationUnit.mm, groupValue:  __settingsNotifier.precipitationUnit,
                                              onChanged: (PrecipitationUnit? value) => __settingsNotifier.precipitationUnit = value!),
                                          const Text('millimeters')
                                      ]),
                                      Row(children: [
                                          Radio<PrecipitationUnit>(value: PrecipitationUnit.inch, groupValue:  __settingsNotifier.precipitationUnit,
                                              onChanged: (PrecipitationUnit? value) => __settingsNotifier.precipitationUnit = value!),
                                          const Text('Inches'),
                                      ])
                                  ],),
                              ),
                          ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: Text("About", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                      ),
                      Padding(
                          padding:  const EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: theme.surfaceContainerHighest, borderRadius: const BorderRadius.all(Radius.circular(10))),
                              child: Padding(padding: const EdgeInsets.all(8),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Bsoft Weather is developed and maintained by Nobel owned by Bsoft Limited", style: GoogleFonts.aBeeZee(fontSize: 16, letterSpacing: 1.4, fontWeight: FontWeight.w300, color: theme.onSurface),),
                                      const SizedBox(height: 10),
                                      Text("Weather data source: Open-Meteo API", style: TextStyle(fontWeight: FontWeight.w500, color: theme.onSurface),),
                                  ])
                              )
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: Text("Version", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(top: 6, left: 20),
                          child: Text("1.0.0", style: TextStyle(color: Colors.grey, fontSize: 14, letterSpacing: 1.4, fontWeight: FontWeight.w300)),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: Text("Privacy Policy", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: Text("Terms and Condition", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                      ),
                      const SizedBox(height: 12,)
                  ]),
                ),)
            ],
        );
    }
}