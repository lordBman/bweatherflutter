import 'dart:async';

import 'package:bweather_repository/bweather_repository.dart';
import 'package:bweatherflutter/components/details.dart';
import 'package:bweatherflutter/components/error.dart';
import 'package:bweatherflutter/components/others.dart';
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
import 'package:liquid_pull_refresh/liquid_pull_refresh.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'details_section.dart';

class ForecastView extends StatefulWidget{
    final int index;

    const ForecastView({super.key, required this.index});

    @override
    State<StatefulWidget> createState() => __CityStatePageState();
}

class __CityStatePageState extends State<ForecastView> {
    final GlobalKey<LiquidPullRefreshState> refreshIndicatorKey = GlobalKey<LiquidPullRefreshState>();

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
            CityState? cityState = widget.index == -1 ? state.location : state.cities[widget.index];

            if(cityState == null || (cityState.status.isLoading && cityState.city.forecast == null)){
                return const ForecastShimmering();
            }

            if (cityState.status.isFailure || cityState.city.forecast == null){
                return const ErrorView(message: "Encountered an unexpected error when fetching Forecast, check your internet connection");
            }

            Current current = cityState.city.forecast!.current;

            WeatherCode weatherCode = WeatherCode.decode(code: current.weather_code, isNight: !current.is_day);

            String time = formatTime(time: current.time, timezone: (cityState.city.forecast!.utc_offset_seconds / 3600).ceil());

            return LiquidPullRefresh(
                onRefresh: () async{ await weatherCubit.reloadCityForecast(cityState); },
                showChildOpacityTransition: false,
                backgroundColor: theme.surface,
                animSpeedFactor: 2.0,
                color: theme.primary,
                heightLoader: 80,
                height: 80,
                showDroplet: true,
                springAnimationDurationInMilliseconds: 400,
                key: refreshIndicatorKey,
                child: SingleChildScrollView(
                  child: Column(children: [
                      Padding(padding: const EdgeInsets.only(top: 50),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, children: [
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
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          mainAxisSize: ResponsiveBreakpoints.of(context).isMobile ? MainAxisSize.max : MainAxisSize.min,
                                          spacing: ResponsiveBreakpoints.of(context).isMobile ? 0.0 : 20,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
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
                              ])),
                              if(ResponsiveBreakpoints.of(context).isDesktop)...[
                                  SizedBox(width: 380, child: DetailsSection(current: current, city: cityState.city))
                              ]
                          ]),
                      ),
                      SizedBox(height: ResponsiveBreakpoints.of(context).isMobile ? 10: 30,),
                      Others( city: cityState.city),
                      if(ResponsiveBreakpoints.of(context).isMobile)...[
                          Padding(
                              padding: const EdgeInsets.symmetric( horizontal: 10),
                              child: DetailsSection(current: current, city: cityState.city),
                          ),
                      ],
                      const SizedBox(height: 12,)
                  ]),
                ),
            );
        });
    }

    @override
    void dispose() {
        super.dispose();
    }
}