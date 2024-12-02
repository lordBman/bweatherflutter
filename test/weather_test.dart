import 'package:bweather_repository/bweather_repository.dart';
import 'package:bweatherflutter/states/forecast/city_state.dart';
import 'package:bweatherflutter/states/forecast/weather_state.dart';
import 'package:bweatherflutter/states/settings_cubit.dart';
import 'package:bweatherflutter/states/weather_cubit.dart';
import 'package:bweatherflutter/utils/status.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';

import 'helpers.dart';

const List<CityState> cities = [];
const String message = "";
const dynamic error = null;

const StateStatus status = StateStatus.initial;

class MockForecastRepository extends Mock implements ForecastRepository {}

class MockCity extends Mock implements City {}

const citySample = City(name: "Chicago", elevation: 2.4, country: "America", latitude: 41.85003, longitude: -87.65005);

void main(){
    initHydratedStorage();

    group('WeatherCubit', () {
        late City city;
        late ForecastRepository forecastRepository;
        late WeatherCubit weatherCubit;

        setUpAll(() async{
            registerFallbackValue(MockCity());
        });

        setUp((){
            city = MockCity();
            forecastRepository = MockForecastRepository();

            when(() => city.name).thenReturn(citySample.name);
            when(() => city.country).thenReturn(citySample.country);
            when(() => city.latitude).thenReturn(citySample.latitude);
            when(() => city.longitude).thenReturn(citySample.longitude);
            when(() => city.elevation).thenReturn(citySample.elevation);
            when(() => city.timezone).thenReturn("GMT");

            when(() => forecastRepository.getWeather(any())).thenAnswer((_) async => city);

            weatherCubit = WeatherCubit(SettingsCubit(), repository: forecastRepository);
      });

      test('initial state is correct', () {
          final weatherCubit = WeatherCubit(SettingsCubit(), repository: forecastRepository);
          expect(weatherCubit.state, const WeatherState());
      });

      group('toJson/fromJson', () {
          test('work properly', () {
              final weatherCubit = WeatherCubit(SettingsCubit(), repository: forecastRepository);
              expect(
                  weatherCubit.fromJson(weatherCubit.toJson(weatherCubit.state)!),
                  weatherCubit.state,
              );
          });
      });

      group('fetchWeather', () {
          blocTest<WeatherCubit, WeatherState>(
              'emits nothing when city is null',
              build: () => weatherCubit,
              act: (cubit) => cubit.requestCity(null),
              expect: () => <WeatherState>[],
          );

          blocTest<WeatherCubit, WeatherState>(
              'emits nothing when city is empty',
              build: () => weatherCubit,
              act: (cubit) => cubit.requestCity(''),
              expect: () => <WeatherState>[],
          );

          /*blocTest<WeatherCubit, WeatherState>(
              'calls getWeather with correct city',
              build: () => weatherCubit,
              act: (cubit) => cubit.forecast(citySample),
              verify: (_) {
                  verify(() => forecastRepository.getWeather(citySample)).called(1);
              },
          );

          blocTest<WeatherCubit, WeatherState>(
              'emits [loading, failure] when getWeather throws',
              setUp: () {
                  when(
                          () => weatherRepository.getWeather(any()),
                  ).thenThrow(Exception('oops'));
              },
              build: () => weatherCubit,
              act: (cubit) => cubit.fetchWeather(weatherLocation),
              expect: () => <WeatherState>[
                  WeatherState(status: WeatherStatus.loading),
                  WeatherState(status: WeatherStatus.failure),
              ],
          );

          blocTest<WeatherCubit, WeatherState>(
              'emits [loading, success] when getWeather returns (celsius)',
              build: () => weatherCubit,
              act: (cubit) => cubit.fetchWeather(weatherLocation),
              expect: () => <dynamic>[
                  WeatherState(status: WeatherStatus.loading),
                  isA<WeatherState>()
                      .having((w) => w.status, 'status', WeatherStatus.success)
                      .having(
                          (w) => w.weather,
                      'weather',
                      isA<Weather>()
                          .having((w) => w.lastUpdated, 'lastUpdated', isNotNull)
                          .having((w) => w.condition, 'condition', weatherCondition)
                          .having(
                              (w) => w.temperature,
                          'temperature',
                          Temperature(value: weatherTemperature),
                      )
                          .having((w) => w.location, 'location', weatherLocation),
                  ),
              ],
          );

          blocTest<WeatherCubit, WeatherState>(
              'emits [loading, success] when getWeather returns (fahrenheit)',
              build: () => weatherCubit,
              seed: () => WeatherState(temperatureUnits: TemperatureUnits.fahrenheit),
              act: (cubit) => cubit.fetchWeather(weatherLocation),
              expect: () => <dynamic>[
                  WeatherState(
                      status: WeatherStatus.loading,
                      temperatureUnits: TemperatureUnits.fahrenheit,
                  ),
                  isA<WeatherState>()
                      .having((w) => w.status, 'status', WeatherStatus.success)
                      .having(
                          (w) => w.weather,
                      'weather',
                      isA<Weather>()
                          .having((w) => w.lastUpdated, 'lastUpdated', isNotNull)
                          .having((w) => w.condition, 'condition', weatherCondition)
                          .having(
                              (w) => w.temperature,
                          'temperature',
                          Temperature(value: weatherTemperature.toFahrenheit()),
                      )
                          .having((w) => w.location, 'location', weatherLocation),
                  ),
              ],
          );*/
      });

  });
}