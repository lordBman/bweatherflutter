import 'package:bweather_repository/bweather_repository.dart';
import 'package:bweatherflutter/components/clickable.dart';
import 'package:bweatherflutter/components/shimmering/location.dart';
import 'package:bweatherflutter/states/forecast/city_state.dart';
import 'package:bweatherflutter/states/forecast/weather_state.dart';
import 'package:bweatherflutter/states/main_cubit.dart';
import 'package:bweatherflutter/states/weather_cubit.dart';
import 'package:bweatherflutter/utils/status.dart';
import 'package:bweatherflutter/utils/utils.dart';
import 'package:bweatherflutter/utils/weather_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationItem extends StatefulWidget{
    final int index;

    const LocationItem({ super.key, required this.index });

    @override
    State<StatefulWidget> createState() => __LocationItemState();
}

class __LocationItemState extends State<LocationItem>{
    @override
    Widget build(BuildContext context) {
        ColorScheme theme = Theme.of(context).colorScheme;

        return BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state){
                CityState cityState = state.cities[widget.index];

                if(cityState.status.isLoading){
                    return const LocationItemShimmering();
                }

                String temperature = "--", unit = "", time = "--:--";
                int code = 0;
                bool isNight = false;
                if(cityState.city.forecast != null){
                    Current current = cityState.city.forecast!.current;

                    temperature = "${current.temperature.value.ceil()}";
                    unit = current.temperature.unit;

                    time = formatTime(time: current.time, timezone: (cityState.city.forecast!.utc_offset_seconds / 3600).ceil());
                    code = current.weather_code;
                    isNight = !current.is_day;
                }

                return Clickable(clicked: (){ context.read<MainCubit>().index = widget.index; },
                    child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: theme.surfaceContainerHigh,
                            /*boxShadow: [
                                BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 2)),
                            ]*/
                        ),
                        child: Column(children: [
                            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                SvgPicture.asset(WeatherCode.decode(code: code, isNight: isNight).image, width: 100, height: 100),
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Row(
                                        children: [
                                            Expanded(child: Text(cityState.city.name, maxLines: 1, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: theme.primary))),
                                            Visibility(visible: widget.index != 0, child: Container(alignment: Alignment.centerRight,
                                                child: IconButton(style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)), icon: const Icon(Icons.cancel_outlined), color: theme.error, onPressed: (){ context.read<WeatherCubit>().remove(widget.index); }),)),
                                        ],
                                      ),
                                      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Expanded(
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                Text(WeatherCode.decode(code: code, isNight: isNight).description, style: GoogleFonts.aBeeZee(fontSize: 16, fontWeight: FontWeight.w600, color: theme.onSurface)),
                                                Text(time, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: theme.onSurface))
                                            ],),
                                          ),
                                          Text("$temperature°", style: GoogleFonts.fuzzyBubbles(fontSize: 46, letterSpacing: 1.4, fontWeight: FontWeight.w200, color: theme.primary))
                                      ],)
                                  ],),
                                ),
                            ],),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [0, 1, 2, 3, 4].map((index){
                                if(cityState.city.forecast != null){
                                    Hourly hourly = cityState.city.forecast!.hourly[index];

                                    temperature =hourly.temperature.value.ceil().toString();
                                    unit = hourly.temperature.unit;

                                    DateTime initTime = hourly.time;
                                    time = "${initTime.hour}:00";
                                    code = hourly.weather_code;
                                    isNight = hourly.time.hour > 18 || hourly.time.hour < 6;
                                }

                                return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    SvgPicture.asset(WeatherCode.decode(code: code, isNight: isNight).image, height: 60),
                                    Text("$temperature$unit", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.primary)),
                                    Text(time, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: theme.onSurface)),
                                ],);
                            }).toList(),)
                        ],)
                    ),
                  );
            },
        );
    }
}