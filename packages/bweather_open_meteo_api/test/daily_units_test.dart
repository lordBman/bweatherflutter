import 'dart:convert';

import 'package:bweather_open_meteo_api/bweather_open_meteo_api.dart';
import 'package:bweather_open_meteo_api/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DailyUnits', () {
    group('Constructor', () {
      test('returns an instance Daily Units object with Constructor', () {
        expect(DailyUnits(apparent_temperature_max: "°C", apparent_temperature_min: "°C", temperature_2m_min: "°C", temperature_2m_max: "°C",
            precipitation_sum: "mm", rain_sum: "mm", wind_gusts_10m_max: "km/h", wind_speed_10m_max: "km/h"),
            isA<DailyUnits>()
                .having((c) => c.precipitation_sum, 'precipitation sum', 'mm')
                .having((c) => c.temperature_2m_max, 'Max Temperature', "°C")
                .having((c) => c.temperature_2m_min, 'Min Temperature', "°C")
                .having((c) => c.rain_sum, 'total rain', "mm")
                .having((c) => c.wind_gusts_10m_max, 'Max Wind Gust', "km/h")
                .having((c) => c.apparent_temperature_min, 'Min Apparent Temperature', "°C")
                .having((c) => c.apparent_temperature_max, 'Max Apparent Temperature', "°C")
                .having((c) => c.wind_speed_10m_max, 'Max Wind Speed', "km/h"));
      });
    });
    group('fromJson', () {
      test('returns correct Daily Units object from json map', () {
        expect(DailyUnits.fromJson(<String, dynamic>{
            "apparent_temperature_max": "°C", "apparent_temperature_min": "°C", "temperature_2m_min": "°C", "temperature_2m_max": "°C",
            "precipitation_sum": "mm", "rain_sum": "mm", "wind_gusts_10m_max": "km/h", "wind_speed_10m_max": "km/h"
        }),
            isA<DailyUnits>()
                .having((c) => c.precipitation_sum, 'precipitation sum', 'mm')
                .having((c) => c.temperature_2m_max, 'Max Temperature', "°C")
                .having((c) => c.temperature_2m_min, 'Min Temperature', "°C")
                .having((c) => c.rain_sum, 'total rain', "mm")
                .having((c) => c.wind_gusts_10m_max, 'Max Wind Gust', "km/h")
                .having((c) => c.apparent_temperature_min, 'Min Apparent Temperature', "°C")
                .having((c) => c.apparent_temperature_max, 'Max Apparent Temperature', "°C")
                .having((c) => c.wind_speed_10m_max, 'Max Wind Speed', "km/h"));
      });
      test('returns correct Daily Units object from json String', () {
        expect(DailyUnits.fromJson(jsonDecode('''{
            "apparent_temperature_max": "°C", "apparent_temperature_min": "°C", "temperature_2m_min": "°C", "temperature_2m_max": "°C",
            "precipitation_sum": "mm", "rain_sum": "mm", "wind_gusts_10m_max": "km/h", "wind_speed_10m_max": "km/h"
        }''')),
            isA<DailyUnits>()
                .having((c) => c.precipitation_sum, 'precipitation sum', 'mm')
                .having((c) => c.temperature_2m_max, 'Max Temperature', "°C")
                .having((c) => c.temperature_2m_min, 'Min Temperature', "°C")
                .having((c) => c.rain_sum, 'total rain', "mm")
                .having((c) => c.wind_gusts_10m_max, 'Max Wind Gust', "km/h")
                .having((c) => c.apparent_temperature_min, 'Min Apparent Temperature', "°C")
                .having((c) => c.apparent_temperature_max, 'Max Apparent Temperature', "°C")
                .having((c) => c.wind_speed_10m_max, 'Max Wind Speed', "km/h"));
      });
    });
    group('toJson', () {
      test('returns a map json of Daily Units object', () {
        expect(DailyUnits(apparent_temperature_max: "°C", apparent_temperature_min: "°C", temperature_2m_min: "°C", temperature_2m_max: "°C",
            precipitation_sum: "mm", rain_sum: "mm", wind_gusts_10m_max: "km/h", wind_speed_10m_max: "km/h").toJson(),
            isA<Map<String, dynamic>>()
                .having((c) => c["precipitation_sum"], 'precipitation sum', 'mm')
                .having((c) => c["temperature_2m_max"], 'Max Temperature', "°C")
                .having((c) => c["temperature_2m_min"], 'Min Temperature', "°C")
                .having((c) => c["rain_sum"], 'total rain', "mm")
                .having((c) => c["wind_gusts_10m_max"], 'Max Wind Gust', "km/h")
                .having((c) => c["apparent_temperature_min"], 'Min Apparent Temperature', "°C")
                .having((c) => c["apparent_temperature_max"], 'Max Apparent Temperature', "°C")
                .having((c) => c["wind_speed_10m_max"], 'Max Wind Speed', "km/h"));
      });
    });
  });
}