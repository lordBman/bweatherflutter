import 'dart:convert';

import 'package:bweather_open_meteo_api/bweather_open_meteo_api.dart';
import 'package:bweather_open_meteo_api/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HourlyUnits', () {
    group('Constructor', () {
      test('returns an instance Hourly Units object with Contructor', () {
        expect(HourlyUnits(temperature_2m: "°C", relative_humidity_2m: "%", apparent_temperature: "°C", dew_point_2m: "°C", rain: "mm", precipitation_probability: "%"),
            isA<HourlyUnits>()
                .having((c) => c.precipitation_probability, 'precipitation probability', '%')
                .having((c) => c.relative_humidity_2m, 'Relative Humidity', '%')
                .having((c) => c.dew_point_2m, 'Dew Point', "°C")
                .having((c) => c.rain, 'rain', "mm")
                .having((c) => c.apparent_temperature, 'Apparent Temperature', "°C")
                .having((c) => c.temperature_2m, 'Temperature', "°C"));
      });
    });
    group('fromJson', () {
      test('returns correct HourlyUnits object from json map', () {
        expect(HourlyUnits.fromJson(<String, dynamic>{
          "temperature_2m": "°C", "relative_humidity_2m": "%", "apparent_temperature": "°C", "dew_point_2m": "°C",
          "rain": "mm", "precipitation_probability": "%"
        }),
            isA<HourlyUnits>()
                .having((c) => c.precipitation_probability, 'precipitation probability', '%')
                .having((c) => c.relative_humidity_2m, 'Relative Humidity', '%')
                .having((c) => c.dew_point_2m, 'Dew Point', "°C")
                .having((c) => c.rain, 'rain', "mm")
                .having((c) => c.apparent_temperature, 'Apparent Temperature', "°C")
                .having((c) => c.temperature_2m, 'Temperature', "°C"));
      });
      test('returns correct HourlyUnits object from json String', () {
        expect(HourlyUnits.fromJson(jsonDecode('''{
          "temperature_2m": "°C", "relative_humidity_2m": "%", "apparent_temperature": "°C", "dew_point_2m": "°C",
          "rain": "mm", "precipitation_probability": "%"
        }''')),
            isA<HourlyUnits>()
                .having((c) => c.precipitation_probability, 'precipitation probability', '%')
                .having((c) => c.relative_humidity_2m, 'Relative Humidity', '%')
                .having((c) => c.dew_point_2m, 'Dew Point', "°C")
                .having((c) => c.rain, 'rain', "mm")
                .having((c) => c.apparent_temperature, 'Apparent Temperature', "°C")
                .having((c) => c.temperature_2m, 'Temperature', "°C"));
      });
    });
    group('toJson', () {
      test('returns a map json of HourlyUnits object', () {
        expect(HourlyUnits(temperature_2m: "°C", relative_humidity_2m: "%", apparent_temperature: "°C", dew_point_2m: "°C", rain: "mm", precipitation_probability: "%").toJson(),
            isA<Map<String, dynamic>>()
                .having((c) => c["precipitation_probability"], 'precipitation probability', '%')
                .having((c) => c["relative_humidity_2m"], 'Relative Humidity', '%')
                .having((c) => c["dew_point_2m"], 'Dew Point', "°C")
                .having((c) => c["rain"], 'rain', "mm")
                .having((c) => c["apparent_temperature"], 'Apparent Temperature', "°C")
                .having((c) => c["temperature_2m"], 'Temperature', "°C"));
      });
    });
  });
}