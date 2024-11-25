import 'dart:convert';

import 'package:bweather_open_meteo_api/bweather_open_meteo_api.dart';
import 'package:bweather_open_meteo_api/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrentUnits', () {
    group('Constructor', () {
      test('returns an instance City object', () {
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
      test('returns correct City object', () {
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
      test('returns correct City object', () {
        expect(City.fromJson(jsonDecode('{ "name": "Chicago", "elevation": 2.4, "country": "America", "latitude": 41.85003, "longitude": -87.65005 }')),
            isA<City>()
                .having((w) => w.name, 'name', 'Chicago')
                .having((w) => w.country, 'country', 'America')
                .having((w) => w.elevation, 'elevation', 2.4)
                .having((w) => w.latitude, 'latitude', 41.85003)
                .having((w) => w.longitude, 'longitude', -87.65005));
      });
    });
    group('toJson', () {
      test('returns a map json of City object', () {
        expect(const City(name: 'Chicago', elevation: 2.4, country: "America", latitude: 41.85003, longitude: -87.65005).toJson(),
            isA<Map<String, dynamic>>()
                .having((c) => c["name"], "name", "Chicago")
                .having((c) => c["country"], "country", "America")
                .having((c) => c["elevation"], "elevation", 2.4)
                .having((c) => c["latitude"], "latitude", 41.85003)
                .having((c) => c["longitude"], "longitude", -87.65005));
      });
      test('returns a serialized json of City object', () {
        expect(const City(name: 'Chicago', elevation: 2.4, country: "America", latitude: 41.85003, longitude: -87.65005).serialize(),
            isA<String>()
                .having((c) => c, "Serialized", '{"name":"Chicago","timezone":"auto","elevation":2.4,"country":"America","latitude":41.85003,"longitude":-87.65005}'));
      });
    });
  });
}