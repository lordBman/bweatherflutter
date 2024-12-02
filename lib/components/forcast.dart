import 'dart:async';

import 'package:bweather_repository/bweather_repository.dart';
import 'package:bweatherflutter/components/details.dart';
import 'package:bweatherflutter/components/error.dart';
import 'package:bweatherflutter/components/others.dart';
import 'package:bweatherflutter/components/refresh.dart';
import 'package:bweatherflutter/components/shimmering/forcast.dart';
import 'package:bweatherflutter/states/forecast/city_state.dart';
import 'package:bweatherflutter/states/forecast/weather_state.dart';
import 'package:bweatherflutter/states/weather_cubit.dart';
import 'package:bweatherflutter/utils/status.dart';
import 'package:bweatherflutter/utils/utils.dart';
import 'package:bweatherflutter/utils/weather_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForecastView extends StatefulWidget{
    final int index;

    const ForecastView({super.key, required this.index});

    @override
    State<StatefulWidget> createState() => __cityStatePageState();
}

class __cityStatePageState extends State<ForecastView> {
    late WeatherCubit weatherCubit;
    late WeatherState weatherState;

    Future<bool> refresh() async{
        await weatherCubit.reloadCityForecast(weatherState.cities[widget.index]);

        return true;
    }

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        weatherCubit = context.read<WeatherCubit>();

        return BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state){
            CityState cityState = state.cities[widget.index];

            if(cityState.status.isLoading && cityState.city.forecast == null){
                return const ForecastShimmering();
            }

            if (cityState.status.isFailure || cityState.city.forecast == null){
                return const ErrorView(message: "Encountered an unexpected error when fetching Forecast, check your internet connection");
            }

            Current current = cityState.city.forecast!.current;

            WeatherCode weatherCode = WeatherCode.decode(code: current.weather_code, isNight: !current.is_day);

            String time = formatTime(time: current.time, timezone: (cityState.city.forecast!.utc_offset_seconds / 3600).ceil());

            return Refresh( refresh: refresh, image: "files/animations/Animation - 1730523394311.json",
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                            Text(cityState.city.name, style: TextStyle(color: theme.primary, fontSize: 36, fontWeight: FontWeight.w300)),
                            Text(cityState.city.country, style: const TextStyle(color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.w300)),
                            const SizedBox(height: 10,),
                            Text(formatDate(DateTime.now()) , style: TextStyle(color: theme.onSurface, fontSize: 18, fontWeight: FontWeight.w300)),
                            const SizedBox(height: 4),
                            Text(time, style: TextStyle(color: theme.onSurface, fontSize: 18, fontWeight: FontWeight.w300)),
                            Row(mainAxisSize: MainAxisSize.min, children: [
                                Text("${current.temperature.value.ceil()}${current.temperature.unit}", style: GoogleFonts.fuzzyBubbles(fontSize: 80, fontWeight: FontWeight.w300, color:  theme.primary)),
                                SvgPicture.asset(weatherCode.image, height: 160)
                            ]),
                            Text("feels like ${current.apparent_temperature.value}${current.apparent_temperature.unit}", style: const TextStyle(color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 8),
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(weatherCode.description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.blueGrey, letterSpacing: 1.4, fontSize: 18, fontWeight: FontWeight.w600)),),
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                        Row(children: [
                                            SvgPicture.asset("files/cloud-bolt-rain.svg", width: 30, colorFilter: const ColorFilter.mode( Colors.blueGrey, BlendMode.srcIn),),
                                            const SizedBox(width: 8,),
                                            Text("${current.rain.value.ceil()}${current.rain.unit}", style: const TextStyle(fontSize: 22, color: Colors.blueGrey),),
                                        ]),
                                        const SizedBox(height: 8,),
                                        const Text("Rain Sum", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),)
                                    ]),
                                    const SizedBox(height: 50, child: VerticalDivider(color: Colors.blueGrey, thickness: 2,)),
                                    Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                        Row(children: [
                                            SvgPicture.asset("files/leaf.svg", width: 30, colorFilter: const ColorFilter.mode( Colors.blueGrey, BlendMode.srcIn),),
                                            const SizedBox(width: 3,),
                                            Text("${current.wind_speed.value.ceil()}${current.wind_speed.unit}", style: const TextStyle(fontSize: 22, color: Colors.blueGrey),),
                                        ]),
                                        const SizedBox(height: 8,),
                                        const Text("Wind Speed", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),)
                                    ]),
                                    const SizedBox(height: 50, child: VerticalDivider(color: Colors.blueGrey, thickness: 2,)),
                                    Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                        Row(children: [
                                            const Icon(Icons.water_drop_outlined, color: Colors.blueGrey, size: 32,),
                                            const SizedBox(width: 3,),
                                            Text("${current.relative_humidity.value.ceil()}${current.relative_humidity.unit}", style: const TextStyle(fontSize: 22, color: Colors.blueGrey),),
                                        ]),
                                        const SizedBox(height: 8,),
                                        const Text("Humidity", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),)
                                    ],)
                                ],),
                            )
                        ]),
                    ),
                    const SizedBox(height: 10,),
                    Others( city: cityState.city),
                    Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 10),
                      child: GridView.count(crossAxisCount: 2, physics: const NeverScrollableScrollPhysics(), shrinkWrap: true,
                      crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.4,
                      children: [
                          Details(title: "Wind Direction", info: "${current.wind_direction.value}${current.wind_direction.unit}", iconAsset: "noto--compass.svg"),
                          Details(title: "Wind Guts", info: "${current.wind_gusts.value}${current.wind_gusts.unit}", iconAsset: "fluent-emoji-flat--leaf-fluttering-in-wind.svg"),
                          Details(title: "Rain", info: "${cityState.city.forecast?.hourly[DateTime.now().hour].rain.value.ceil()}${cityState.city.forecast?.hourly[DateTime.now().hour].rain.unit}", iconAsset: "emojione--umbrella-with-rain-drops.svg"),
                          Details(title: "Pressure", info: "${current.surface_pressure.value.ceil()}${current.surface_pressure.unit}", iconAsset: "emojione--stopwatch.svg"),
                          Details(title: "Cloud Cover", info: "${current.cloud_cover.value}${current.cloud_cover.unit}", iconAsset: "emojione--sun-behind-cloud.svg"),
                          Details(title: "Precipitation", info: "${current.precipitation.value.ceil()}${current.precipitation.unit}", iconAsset: "twemoji--droplet.svg"),
                      ]),
                    ),
                    const SizedBox(height: 12,)
                ]),
            );
        });
    }

    @override
    void dispose() {
        super.dispose();
    }
}