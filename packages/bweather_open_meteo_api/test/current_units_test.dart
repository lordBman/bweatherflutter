import 'dart:convert';

import 'package:bweather_open_meteo_api/bweather_open_meteo_api.dart';
import 'package:bweather_open_meteo_api/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrentUnits', () {
    group('Constructor', () {
      test('returns an instance Current Units object with Contructor', () {
        expect(CurrentUnits( temperature_2m: "°C", relative_humidity_2m: "%", apparent_temperature: "°C", pressure_msl: "hPa", precipitation: "mm",
            rain: "mm", cloud_cover: "%", surface_pressure: "hPa", wind_speed_10m: "km/h", wind_direction_10m: "°", wind_gusts_10m: "km/h"),
            isA<CurrentUnits>()
                .having((c) => c.precipitation, 'precipitation', 'mm')
                .having((c) => c.relative_humidity_2m, 'Relative Humidity', '%')
                .having((c) => c.cloud_cover, 'Cloud Cover', '%')
                .having((c) => c.surface_pressure, 'Surface Pressure', "hPa")
                .having((c) => c.rain, 'rain', "mm")
                .having((c) => c.wind_gusts_10m, 'Wind Gust', "km/h")
                .having((c) => c.pressure_msl, 'Sea Level Pressure', "hPa")
                .having((c) => c.apparent_temperature, 'Apparent Temperature', "°C")
                .having((c) => c.wind_direction_10m, 'Wind Direction', "°")
                .having((c) => c.wind_speed_10m, 'Wind Speed', "km/h")
                .having((c) => c.temperature_2m, 'Temperature', "°C"));
      });
    });
    group('fromJson', () {
      test('returns correct CurrentUnits object from json map', () {
        expect(CurrentUnits.fromJson(<String, dynamic>{
          "temperature_2m": "°C", "relative_humidity_2m": "%", "apparent_temperature": "°C", "precipitation": "mm",
          "rain": "mm", "cloud_cover": "%", "pressure_msl": "hPa", "surface_pressure": "hPa",
          "wind_speed_10m": "km/h", "wind_direction_10m": "°", "wind_gusts_10m": "km/h"
        }),
            isA<CurrentUnits>()
                .having((c) => c.precipitation, 'precipitation', 'mm')
                .having((c) => c.relative_humidity_2m, 'Relative Humidity', '%')
                .having((c) => c.cloud_cover, 'Cloud Cover', '%')
                .having((c) => c.surface_pressure, 'Surface Pressure', "hPa")
                .having((c) => c.rain, 'rain', "mm")
                .having((c) => c.wind_gusts_10m, 'Wind Gust', "km/h")
                .having((c) => c.pressure_msl, 'Sea Level Pressure', "hPa")
                .having((c) => c.apparent_temperature, 'Apparent Temperature', "°C")
                .having((c) => c.wind_direction_10m, 'Wind Direction', "°")
                .having((c) => c.wind_speed_10m, 'Wind Speed', "km/h")
                .having((c) => c.temperature_2m, 'Temperature', "°C"));
      });
      test('returns correct CurrentUnits object from json String', () {
        expect(CurrentUnits.fromJson(jsonDecode('''{
          "temperature_2m": "°C", "relative_humidity_2m": "%", "apparent_temperature": "°C", "precipitation": "mm",
          "rain": "mm", "cloud_cover": "%", "pressure_msl": "hPa", "surface_pressure": "hPa",
          "wind_speed_10m": "km/h", "wind_direction_10m": "°", "wind_gusts_10m": "km/h"
        }''')),
            isA<CurrentUnits>()
                .having((c) => c.precipitation, 'precipitation', 'mm')
                .having((c) => c.relative_humidity_2m, 'Relative Humidity', '%')
                .having((c) => c.cloud_cover, 'Cloud Cover', '%')
                .having((c) => c.surface_pressure, 'Surface Pressure', "hPa")
                .having((c) => c.rain, 'rain', "mm")
                .having((c) => c.wind_gusts_10m, 'Wind Gust', "km/h")
                .having((c) => c.pressure_msl, 'Sea Level Pressure', "hPa")
                .having((c) => c.apparent_temperature, 'Apparent Temperature', "°C")
                .having((c) => c.wind_direction_10m, 'Wind Direction', "°")
                .having((c) => c.wind_speed_10m, 'Wind Speed', "km/h")
                .having((c) => c.temperature_2m, 'Temperature', "°C"));
      });
    });
    group('toJson', () {
      test('returns a map json of Current Units object', () {
        expect(CurrentUnits( temperature_2m: "°C", relative_humidity_2m: "%", apparent_temperature: "°C", pressure_msl: "hPa", precipitation: "mm",
            rain: "mm", cloud_cover: "%", surface_pressure: "hPa", wind_speed_10m: "km/h", wind_direction_10m: "°", wind_gusts_10m: "km/h").toJson(),
            isA<Map<String, dynamic>>()
                .having((c) => c["precipitation"], 'precipitation', 'mm')
                .having((c) => c["relative_humidity_2m"], 'Relative Humidity', '%')
                .having((c) => c["cloud_cover"], 'Cloud Cover', '%')
                .having((c) => c["surface_pressure"], 'Surface Pressure', "hPa")
                .having((c) => c["rain"], 'rain', "mm")
                .having((c) => c["wind_gusts_10m"], 'Wind Gust', "km/h")
                .having((c) => c["pressure_msl"], 'Sea Level Pressure', "hPa")
                .having((c) => c["apparent_temperature"], 'Apparent Temperature', "°C")
                .having((c) => c["wind_direction_10m"], 'Wind Direction', "°")
                .having((c) => c["wind_speed_10m"], 'Wind Speed', "km/h")
                .having((c) => c["temperature_2m"], 'Temperature', "°C"));
      });
    });
  });
}