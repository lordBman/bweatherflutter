import 'dart:async';
import 'dart:developer';

import 'package:after_layout/after_layout.dart';
import 'package:bweatherflutter/components/error.dart';
import 'package:bweatherflutter/screens/main.dart';
import 'package:bweatherflutter/states/forecast/weather_state.dart';
import 'package:bweatherflutter/states/weather_cubit.dart';
import 'package:bweatherflutter/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  static const String routeName = "splash";

  const Splash({super.key});

  @override
  State<StatefulWidget> createState() => __SplashState();
}

class __SplashState extends State<Splash> with AfterLayoutMixin<Splash>{
    @override
    FutureOr<void> afterFirstLayout(BuildContext context) {
        /*WeatherCubit cubit = context.read<WeatherCubit>();
        cubit.onProceedListener = (){
            Navigator.pushReplacementNamed(context, MainScreen.routeName);
        };
        cubit.init();*/
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        return Scaffold(backgroundColor: theme.surface,
            body: SafeArea(
                child: BlocBuilder<WeatherCubit, WeatherState>(
                  builder: (context, state){
                      return IndexedStack(index: state.status.isFailure ? 1 : 0, children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                              children: [
                                  Expanded(child: Center(child: Lottie.asset("files/animations/Animation - 1730523394311.json", width: 300,))),
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