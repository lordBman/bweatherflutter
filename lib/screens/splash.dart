import 'package:bweatherflutter/components/error.dart';
import 'package:bweatherflutter/screens/main.dart';
import 'package:bweatherflutter/states/forecast/weather_state.dart';
import 'package:bweatherflutter/states/weather_cubit.dart';
import 'package:bweatherflutter/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Splash extends StatelessWidget{
    static const String routeName = "splash";

    const Splash({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(backgroundColor: Colors.white,
            body: SafeArea(
                child: BlocBuilder<WeatherCubit, WeatherState>(
                  builder: (context, state){
                      return IndexedStack(index: state.status.isFailure ? 1 : 0, children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                              children: [
                                  Expanded(child: Center(child: Image.asset("files/splash.jpg", width: 240,))),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                        children: [
                                            const SizedBox(width: 40, child: LoadingIndicator(indicatorType: Indicator.ballTrianglePathColored, colors: [Colors.orange],)),
                                            const SizedBox(height: 10,),
                                            Text(state.message, style: const TextStyle( fontSize: 14, fontWeight: FontWeight.w300, color: Colors.grey),),
                                        ],
                                    ),
                                  ),
                              ],
                          ),
                          ErrorView(message: state.message)
                      ],);
                  }),
            ),
        );
    }
}