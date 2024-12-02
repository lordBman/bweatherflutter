import 'dart:developer';

import 'package:bweatherflutter/screens/cities.dart';
import 'package:bweatherflutter/screens/info.dart';
import 'package:bweatherflutter/screens/not_found.dart';
import 'package:bweatherflutter/screens/splash.dart';
import 'package:bweatherflutter/states/cities_cubit.dart';
import 'package:bweatherflutter/states/forecast/weather_state.dart';
import 'package:bweatherflutter/states/main_cubit.dart';
import 'package:bweatherflutter/states/settings_cubit.dart';
import 'package:bweatherflutter/states/weather_cubit.dart';
import 'package:bweatherflutter/utils/status.dart';
import 'package:bweatherflutter/utils/theme.dart';
import 'package:bweatherflutter/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'screens/main.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
    const SimpleBlocObserver();
    
    @override
    void onCreate(BlocBase<dynamic> bloc) {
        super.onCreate(bloc);
        log('onCreate -- bloc: ${bloc.runtimeType}');
    }
    
    @override
    void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
        super.onEvent(bloc, event);
        log('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
    }
    
    @override
    void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
        super.onChange(bloc, change);
        log('onChange -- bloc: ${bloc.runtimeType}, change: $change');
    }
    
    @override
    void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
        super.onTransition(bloc, transition);
        log('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
    }
    
    @override
    void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
        log('onError -- bloc: ${bloc.runtimeType}, error: $error');
        super.onError(bloc, error, stackTrace);
    }
    
    @override
    void onClose(BlocBase<dynamic> bloc) {
        super.onClose(bloc);
        log('onClose -- bloc: ${bloc.runtimeType}');
    }
}

class App extends StatelessWidget{
    const App({ super.key });

    @override
    Widget build(BuildContext context) {
        return BlocProvider(create: (context) => SettingsCubit(), child: const BWeather());
    }
}

class BWeather extends StatelessWidget {
    const BWeather({super.key});

    @override
    Widget build(BuildContext context) {
        TextTheme textTheme = createTextTheme(context, "Noto Sans Mono", "Acme");

        MaterialTheme theme = MaterialTheme(textTheme);
        SettingsCubit settingsCubit = context.read<SettingsCubit>();

        return MultiBlocProvider(
            providers: [
                BlocProvider(create: (context) => CitiesCubit()),
                BlocProvider(create: (context) => MainCubit()),
                BlocProvider(create: (context) => WeatherCubit(settingsCubit)),
            ],
            child: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) => MaterialApp(title: 'BSoft Weather App',
                    debugShowCheckedModeBanner: false,
                    theme: theme.light(),
                    darkTheme: theme.dark(),
                    themeMode: state.themeModeValue,
                    initialRoute: MainScreen.routeName,
                    onGenerateRoute: (settings) {
                        return MaterialPageRoute(builder: (context) {
                            return BlocBuilder<WeatherCubit, WeatherState>(builder: (_, weatherState){
                                if(weatherState.status == StateStatus.loading && weatherState.cities.isEmpty){
                                    return const Splash();
                                }

                                switch (settings.name) {
                                    case Info.routeName:
                                        return const Info();
                                    case MainScreen.routeName:
                                        return MainScreen();
                                    case CitiesScreen.routeName:
                                        return const CitiesScreen();
                                    default:
                                        return const NotFound();
                                }
                            });
                        });
                    }),
            )
        );
    }
}

void main()async {
    WidgetsFlutterBinding.ensureInitialized();
    HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getTemporaryDirectory());
    Bloc.observer = const SimpleBlocObserver();
    runApp(const App());
}