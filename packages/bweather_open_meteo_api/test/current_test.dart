import 'dart:convert';

import 'package:bweather_open_meteo_api/bweather_open_meteo_api.dart';
import 'package:bweather_open_meteo_api/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Current', () {
    group('Constructor', () {
      test('returns an instance Current object with Constructor', () {
        expect(Current( time: DateTime.parse("2024-11-25T12:30"), temperature_2m: 12.1, relative_humidity_2m: 65, apparent_temperature: 9.2, is_day: 1,
            precipitation: 0, rain: 0, weather_code: 3, cloud_cover: 100, pressure_msl: 1008.9, surface_pressure: 1004.3, wind_speed_10m: 12.8,
            wind_direction_10m: 158, wind_gusts_10m: 29.5),
            isA<Current>()
                .having((c) => c.time.hour, 'hour of the time', 12)
                .having((c) => c.is_day, 'Is Day ?', 1)
                .having((c) => c.weather_code, 'Weather Code', 3)
                .having((c) => c.precipitation, 'precipitation', 0)
                .having((c) => c.relative_humidity_2m, 'Relative Humidity', 65)
                .having((c) => c.cloud_cover, 'Cloud Cover', 100)
                .having((c) => c.surface_pressure, 'Surface Pressure', 1004.3)
                .having((c) => c.rain, 'rain', 0)
                .having((c) => c.wind_gusts_10m, 'Wind Gust', 29.5)
                .having((c) => c.pressure_msl, 'Sea Level Pressure', 1008.9)
                .having((c) => c.apparent_temperature, 'Apparent Temperature', 9.2)
                .having((c) => c.wind_direction_10m, 'Wind Direction', 158)
                .having((c) => c.wind_speed_10m, 'Wind Speed', 12.8)
                .having((c) => c.temperature_2m, 'Temperature', 12.1));
      });
    });
    group('fromJson', () {
      test('returns correct Current object from json map', () {
        expect(Current.fromJson(<String, dynamic>{
            "time": "2024-11-25T12:30", "temperature_2m": 12.1, "relative_humidity_2m": 65, "apparent_temperature": 9.2, "is_day": 1,
            "precipitation": 0, "rain": 0, "weather_code": 3, "cloud_cover": 100, "pressure_msl": 1008.9, "surface_pressure": 1004.3, "wind_speed_10m": 12.8,
            "wind_direction_10m": 158, "wind_gusts_10m": 29.5
        }),
            isA<Current>()
                .having((c) => c.time.hour, 'hour of the time', 12)
                .having((c) => c.is_day, 'Is Day ?', 1)
                .having((c) => c.weather_code, 'Weather Code', 3)
                .having((c) => c.precipitation, 'precipitation', 0)
                .having((c) => c.relative_humidity_2m, 'Relative Humidity', 65)
                .having((c) => c.cloud_cover, 'Cloud Cover', 100)
                .having((c) => c.surface_pressure, 'Surface Pressure', 1004.3)
                .having((c) => c.rain, 'rain', 0)
                .having((c) => c.wind_gusts_10m, 'Wind Gust', 29.5)
                .having((c) => c.pressure_msl, 'Sea Level Pressure', 1008.9)
                .having((c) => c.apparent_temperature, 'Apparent Temperature', 9.2)
                .having((c) => c.wind_direction_10m, 'Wind Direction', 158)
                .having((c) => c.wind_speed_10m, 'Wind Speed', 12.8)
                .having((c) => c.temperature_2m, 'Temperature', 12.1));
      });
      test('returns correct Current object from json String', () {
        expect(Current.fromJson(jsonDecode('''{
          "time": "2024-11-25T12:30", "temperature_2m": 12.1, "relative_humidity_2m": 65, "apparent_temperature": 9.2, "is_day": 1,
            "precipitation": 0, "rain": 0, "weather_code": 3, "cloud_cover": 100, "pressure_msl": 1008.9, "surface_pressure": 1004.3, "wind_speed_10m": 12.8,
            "wind_direction_10m": 158, "wind_gusts_10m": 29.5
        }''')),
            isA<Current>()
                .having((c) => c.time.hour, 'hour of the time', 12)
                .having((c) => c.is_day, 'Is Day ?', 1)
                .having((c) => c.weather_code, 'Weather Code', 3)
                .having((c) => c.precipitation, 'precipitation', 0)
                .having((c) => c.relative_humidity_2m, 'Relative Humidity', 65)
                .having((c) => c.cloud_cover, 'Cloud Cover', 100)
                .having((c) => c.surface_pressure, 'Surface Pressure', 1004.3)
                .having((c) => c.rain, 'rain', 0)
                .having((c) => c.wind_gusts_10m, 'Wind Gust', 29.5)
                .having((c) => c.pressure_msl, 'Sea Level Pressure', 1008.9)
                .having((c) => c.apparent_temperature, 'Apparent Temperature', 9.2)
                .having((c) => c.wind_direction_10m, 'Wind Direction', 158)
                .having((c) => c.wind_speed_10m, 'Wind Speed', 12.8)
                .having((c) => c.temperature_2m, 'Temperature', 12.1));
      });
    });
    group('toJson', () {
      test('returns a map json of Current Units object', () {
        expect(Current( time: DateTime.parse("2024-11-25T12:30"), temperature_2m: 12.1, relative_humidity_2m: 65, apparent_temperature: 9.2, is_day: 1,
            precipitation: 0, rain: 0, weather_code: 3, cloud_cover: 100, pressure_msl: 1008.9, surface_pressure: 1004.3, wind_speed_10m: 12.8,
            wind_direction_10m: 158, wind_gusts_10m: 29.5).toJson(),
            isA<Map<String, dynamic>>()
                .having((c) => c["time"] is String, 'instance of String', true)
                .having((c) => c["is_day"], 'Is Day ?', 1)
                .having((c) => c["weather_code"], 'Weather Code', 3)
                .having((c) => c["precipitation"], 'precipitation', 0)
                .having((c) => c["relative_humidity_2m"], 'Relative Humidity', 65)
                .having((c) => c["cloud_cover"], 'Cloud Cover', 100)
                .having((c) => c["surface_pressure"], 'Surface Pressure', 1004.3)
                .having((c) => c["rain"], 'rain', 0)
                .having((c) => c["wind_gusts_10m"], 'Wind Gust', 29.5)
                .having((c) => c["pressure_msl"], 'Sea Level Pressure', 1008.9)
                .having((c) => c["apparent_temperature"], 'Apparent Temperature', 9.2)
                .having((c) => c["wind_direction_10m"], 'Wind Direction', 158)
                .having((c) => c["wind_speed_10m"], 'Wind Speed', 12.8)
                .having((c) => c["temperature_2m"], 'Temperature', 12.1));
      });
    });
  });
}