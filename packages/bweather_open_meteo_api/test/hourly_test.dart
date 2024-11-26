import 'dart:convert';

import 'package:bweather_open_meteo_api/bweather_open_meteo_api.dart';
import 'package:bweather_open_meteo_api/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const json = '''{
    "weather_code" : [ 10, 10 ], "time": [ "2024-11-25T06:00", "2024-11-25T07:00" ],
    "temperature_2m": [ 32, 45 ], "relative_humidity_2m": [ 10, 10 ], "apparent_temperature": [ 35, 42 ], "dew_point_2m": [ 12, 15 ],
    "rain": [0, 0], "precipitation_probability": [ 30, 0 ]
  }''';
  group('Hourly', () {
    group('fromJson', () {
      test('returns correct HourlyUnits object from json map', () {
        expect(Hourly.fromJson(jsonDecode(json)),
            isA<Hourly>()
                .having((c) => c.weather_code, 'Weather Codes', [ 10, 10])
                .having((c) => c.time, 'Time', [DateTime.parse("2024-11-25T06:00"),  DateTime.parse("2024-11-25T07:00") ])
                .having((c) => c.precipitation_probability, 'precipitation probability', [ 30, 0])
                .having((c) => c.relative_humidity_2m, 'Relative Humidity', [ 10, 10])
                .having((c) => c.dew_point_2m, 'Dew Point', [ 12, 15 ])
                .having((c) => c.rain, 'rain', [0, 0])
                .having((c) => c.apparent_temperature, 'Apparent Temperature',  [ 35, 42 ])
                .having((c) => c.temperature_2m, 'Temperature', [ 32, 45 ]));
      });
    });
    group('toJson', () {
      test('returns a map json of Hourly object', () {
        expect(Hourly(
            weather_code : [ 10, 10 ],
            time: [ DateTime.parse("2024-11-25T06:00"), DateTime.parse("2024-11-25T07:00") ],
            temperature_2m : [ 32, 45 ], relative_humidity_2m: [ 10, 10 ], apparent_temperature: [ 35, 42 ],
            dew_point_2m : [ 12, 15 ],
            rain: [0, 0], precipitation_probability: [ 30, 0 ]
          ).toJson(),
            isA<Map<String, dynamic>>()
                .having((c) => c["weather_code"], 'Weather Code', [ 10, 10 ])
                .having((c) => c["time"] is List<String>, 'Time', true)
                .having((c) => c["precipitation_probability"], 'precipitation probability', [ 30, 0 ])
                .having((c) => c["relative_humidity_2m"], 'Relative Humidity', [ 10, 10 ])
                .having((c) => c["dew_point_2m"], 'Dew Point', [ 12, 15 ])
                .having((c) => c["rain"], 'rain', [0, 0])
                .having((c) => c["apparent_temperature"], 'Apparent Temperature', [ 35, 42 ])
                .having((c) => c["temperature_2m"], 'Temperature', [ 32, 45 ]));
      });
    });
  });
}