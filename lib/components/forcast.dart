import 'dart:async';

import 'package:bweatherflutter/components/details.dart';
import 'package:bweatherflutter/components/error.dart';
import 'package:bweatherflutter/components/others.dart';
import 'package:bweatherflutter/components/refresh.dart';
import 'package:bweatherflutter/components/shimmering/forcast.dart';
import 'package:bweatherflutter/providers/settings.dart';
import 'package:bweatherflutter/providers/weather.dart';
import 'package:bweatherflutter/utils/result.dart';
import 'package:bweatherflutter/utils/utils.dart';
import 'package:bweatherflutter/utils/weather_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_refresh/liquid_pull_refresh.dart';
import 'package:provider/provider.dart';

class ForecastView extends StatefulWidget{
    final int index;

    ForecastView({super.key, required this.index});

    @override
    State<StatefulWidget> createState() => __ForecastStatePageState();
}

class __ForecastStatePageState extends State<ForecastView> {
    late WeatherNotifier weatherNotifier;
    late SettingsNotifier settingsNotifier;


    Future<bool> refresh() async{
        await weatherNotifier.reloadCityForecast(weatherNotifier.savedCities[widget.index]);

        return true;
    }

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        weatherNotifier = context.watch<WeatherNotifier>();
        settingsNotifier = context.watch<SettingsNotifier>();
        
        ForecastState forecastState = weatherNotifier.savedCities[widget.index];

        if(forecastState.loading && forecastState.result == null){
            return const ForecastShimmering();
        }

        if (forecastState.isError){
            return const ErrorView(message: "Encountered an unexpected error when fetching Forecast, check your internet connection");
        }

        //Current current = forecastState.result!.current;
        CurrentUnits units = forecastState.result!.current_units;
        WeatherCode weatherCode = WeatherCode.decode(code: current.weather_code, isNight: current.is_day == 0);

        DateTime initTime = current.time.add(Duration(minutes: (forecastState.city.timezone * 60).ceil()));
        String time = formatTime(time: initTime, timezone: forecastState.city.timezone.ceil());

        return Refresh( refresh: refresh, image: "files/animations/Animation - 1730523394311.json",
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                        Text(forecastState.city.name, style: TextStyle(color: theme.primary, fontSize: 36, fontWeight: FontWeight.w300)),
                        Text(forecastState.city.country, style: const TextStyle(color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.w300)),
                        const SizedBox(height: 10,),
                        Text(formatDate(DateTime.now()) , style: TextStyle(color: theme.onSurface, fontSize: 18, fontWeight: FontWeight.w300)),
                        const SizedBox(height: 4),
                        Text(time, style: TextStyle(color: theme.onSurface, fontSize: 18, fontWeight: FontWeight.w300)),
                        Row(mainAxisSize: MainAxisSize.min, children: [
                            Text("${current.temperature_2m.ceil()}${units.temperature_2m}", style: GoogleFonts.fuzzyBubbles(fontSize: 80, fontWeight: FontWeight.w300, color:  theme.primary)),
                            SvgPicture.asset(weatherCode.image, height: 160)
                        ]),
                        Text("feels like ${current.apparent_temperature}${units.apparent_temperature}", style: const TextStyle(color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(weatherCode.description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.blueGrey, letterSpacing: 1.4, fontSize: 18, fontWeight: FontWeight.w600)),),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Row(children: [
                                        SvgPicture.asset("files/cloud-bolt-rain.svg", width: 30, colorFilter: const ColorFilter.mode( Colors.blueGrey, BlendMode.srcIn),),
                                        const SizedBox(width: 8,),
                                        Text("${forecastState.result?.daily.rain_sum.first.ceil()}${forecastState.result?.daily_units.rain_sum}", style: const TextStyle(fontSize: 22, color: Colors.blueGrey),),
                                    ]),
                                    const SizedBox(height: 8,),
                                    const Text("Rain Sum", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),)
                                ]),
                                const SizedBox(height: 50, child: VerticalDivider(color: Colors.blueGrey, thickness: 2,)),
                                Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Row(children: [
                                        SvgPicture.asset("files/leaf.svg", width: 30, colorFilter: const ColorFilter.mode( Colors.blueGrey, BlendMode.srcIn),),
                                        const SizedBox(width: 3,),
                                        Text("${current.wind_speed_10m.ceil()}${units.wind_speed_10m}", style: const TextStyle(fontSize: 22, color: Colors.blueGrey),),
                                    ]),
                                    const SizedBox(height: 8,),
                                    const Text("Wind Speed", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),)
                                ]),
                                const SizedBox(height: 50, child: VerticalDivider(color: Colors.blueGrey, thickness: 2,)),
                                Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Row(children: [
                                        const Icon(Icons.water_drop_outlined, color: Colors.blueGrey, size: 32,),
                                        const SizedBox(width: 3,),
                                        Text("${current.relative_humidity_2m.ceil()}${units.relative_humidity_2m}", style: const TextStyle(fontSize: 22, color: Colors.blueGrey),),
                                    ]),
                                    const SizedBox(height: 8,),
                                    const Text("Humidity", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),)
                                ],)
                            ],),
                        )
                    ]),
                ),
                const SizedBox(height: 10,),
                Others( result: forecastState.result!, city: forecastState.city ),
                Padding(
                  padding: const EdgeInsets.symmetric( horizontal: 10),
                  child: GridView.count(crossAxisCount: 2, physics: const NeverScrollableScrollPhysics(), shrinkWrap: true,
                  crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.4,
                  children: [
                      Details(title: "Wind Direction", info: "${current.wind_direction_10m}${units.wind_direction_10m}", iconAsset: "noto--compass.svg"),
                      Details(title: "Wind Guts", info: "${current.wind_gusts_10m}${units.wind_gusts_10m}", iconAsset: "fluent-emoji-flat--leaf-fluttering-in-wind.svg"),
                      Details(title: "Rain", info: "${current.rain}${units.rain}", iconAsset: "emojione--umbrella-with-rain-drops.svg"),
                      Details(title: "Pressure", info: "${current.pressure_msl.ceil()}${units.pressure_msl}", iconAsset: "emojione--stopwatch.svg"),
                      Details(title: "Cloud Cover", info: "${current.cloud_cover}${units.cloud_cover}", iconAsset: "emojione--sun-behind-cloud.svg"),
                      Details(title: "Precipitation", info: "${current.precipitation}${units.precipitation}", iconAsset: "twemoji--droplet.svg"),

                  ]),
                ),
                const SizedBox(height: 12,)
            ]),
        );
    }

    @override
    void dispose() {
        super.dispose();
    }
}