import 'dart:convert';

import 'package:bweather_open_meteo_api/bweather_open_meteo_api.dart';
import 'package:bweather_open_meteo_api/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const json = '''{
        "time": [ "2024-11-26", "2024-11-27" ],
        "sunrise": [ "2024-11-26", "2024-11-27" ],
        "sunset": [ "2024-11-26", "2024-11-27" ],
        "weather_code": [ 80, 63 ],
        "temperature_2m_max": [10.6, 7.5 ],
        "temperature_2m_min": [ 7.2, 4.9 ],
        "apparent_temperature_min": [ 5.3, 2.6 ],
        "apparent_temperature_max": [ 5.3, 2.6 ],
        "precipitation_sum": [ 1.6, 10.2 ],
        "rain_sum": [ 1.3, 10.3 ],
        "precipitation_probability_max": [ 100, 90 ],
        "wind_speed_10m_max": [ 11.2, 17.1 ],
        "wind_gusts_10m_max": [ 27.7, 37.1 ],
        "wind_direction_10m_dominant": [ 243, 179]
    }''';
  group('Daily', () {
    group('fromJson', () {
      test('returns correct Daily object from json map', () {
        expect(Daily.fromJson(jsonDecode(json)),
            isA<Daily>()
                .having((c) => c.weather_code, 'Weather Codes', [ 80, 63 ])
                .having((c) => c.time, 'Time', [DateTime.parse("2024-11-26"),  DateTime.parse("2024-11-27") ])
                .having((c) => c.precipitation_sum , 'Precipitation Sum', [ 1.6, 10.2 ])
                .having((c) => c.wind_speed_10m_max, 'Wind Speed', [ 11.2, 17.1 ])
                .having((c) => c.wind_gusts_10m_max, 'Wind Gust', [ 27.7, 37.1 ])
                .having((c) => c.temperature_2m_max, 'Temperature Max', [10.6, 7.5 ])
                .having((c) => c.temperature_2m_min, 'Temperature Min', [ 7.2, 4.9 ])
                .having((c) => c.apparent_temperature_max, 'Apparent Temperature Max', [ 5.3, 2.6 ])
                .having((c) => c.apparent_temperature_min, 'Apparent Temperature Min', [ 5.3, 2.6 ])
                .having((c) => c.sunrise, 'Sunrise', [DateTime.parse("2024-11-26"),  DateTime.parse("2024-11-27") ])
                .having((c) => c.sunset, 'Sunset', [DateTime.parse("2024-11-26"),  DateTime.parse("2024-11-27") ])
                .having((c) => c.rain_sum, 'Rain Sum', [ 1.3, 10.3 ]));
      });
    });
    group('toJson', () {
      test('returns a map json of Hourly object', () {
        expect(Daily(
            weather_code : [ 80, 63 ],
            time: [DateTime.parse("2024-11-26"),  DateTime.parse("2024-11-27") ],
            sunset: [DateTime.parse("2024-11-26"),  DateTime.parse("2024-11-27") ],
            sunrise: [DateTime.parse("2024-11-26"),  DateTime.parse("2024-11-27") ],
            temperature_2m_min : [ 7.2, 4.9 ],  apparent_temperature_min: [ 5.3, 2.6 ],
            temperature_2m_max : [10.6, 7.5 ],  apparent_temperature_max: [ 5.3, 2.6 ],
            rain_sum: [ 1.3, 10.3 ], precipitation_sum: [ 1.6, 10.2 ],
            wind_speed_10m_max: [ 11.2, 17.1 ], wind_gusts_10m_max: [ 27.7, 37.1 ]
        ).toJson(),
            isA<Map<String, dynamic>>()
                .having((c) => c["weather_code"], 'Weather Codes', [ 80, 63 ])
                .having((c) => c["time"], 'Time', ['2024-11-26 00:00:00.000', '2024-11-27 00:00:00.000'])
                .having((c) => c["precipitation_sum"] , 'Precipitation Sum', [ 1.6, 10.2 ])
                .having((c) => c["wind_speed_10m_max"], 'Wind Speed', [ 11.2, 17.1 ])
                .having((c) => c["wind_gusts_10m_max"], 'Wind Gust', [ 27.7, 37.1 ])
                .having((c) => c["temperature_2m_max"], 'Temperature Max', [10.6, 7.5 ])
                .having((c) => c["temperature_2m_min"], 'Temperature Min', [ 7.2, 4.9 ])
                .having((c) => c["apparent_temperature_max"], 'Apparent Temperature Max', [ 5.3, 2.6 ])
                .having((c) => c["apparent_temperature_min"], 'Apparent Temperature Min', [ 5.3, 2.6 ])
                .having((c) => c["sunrise"], 'Sunrise', ['2024-11-26 00:00:00.000', '2024-11-27 00:00:00.000'])
                .having((c) => c["sunset"], 'Sunset', ['2024-11-26 00:00:00.000', '2024-11-27 00:00:00.000'])
                .having((c) => c["rain_sum"], 'Rain Sum', [ 1.3, 10.3 ]));
      });
    });
  });
}