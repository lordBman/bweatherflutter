import 'dart:convert';
import 'package:bweather_repository/models/city.dart';
import 'package:bweather_repository/models/forecast.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:equatable/equatable.dart';

// Assuming City, Forecast, Current, Hourly, Daily, and Value classes are imported here

void main() {
  group('City tests', () {
    test('City should serialize to JSON correctly', () {
      final city = City(
        name: "San Francisco",
        country: "USA",
        timezone: "America/Los_Angeles",
        elevation: 16.0,
        latitude: 37.7749,
        longitude: -122.4194,
        forecast: Forecast(
          utc_offset_seconds: -28800,
          current: Current(
            time: DateTime.parse("2024-11-27T12:00:00Z"),
            weather_code: 101,
            temperature: const Value(value: 15.0, unit: "C"),
            apparent_temperature: const Value(value: 14.0, unit: "C"),
            wind_speed: const Value(value: 5.0, unit: "m/s"),
            wind_gusts: const Value(value: 8.0, unit: "m/s"),
            wind_direction: const Value(value: 180, unit: "°"),
            relative_humidity: const Value(value: 70, unit: "%"),
            surface_pressure: const Value(value: 1012.0, unit: "hPa"),
            rain: const Value(value: 0.1, unit: "mm"),
            precipitation: const Value(value: 0.2, unit: "mm"),
            cloud_cover: const Value(value: 50, unit: "%"),
            is_day: true,
          ),
          hourly: [],
          daily: [],
        ),
      );

      final json = city.toJson();
      expect(json["name"], "San Francisco");
      expect(json["country"], "USA");
      expect(json["timezone"], "America/Los_Angeles");
      expect(json["elevation"], 16.0);
      expect(json["latitude"], 37.7749);
      expect(json["longitude"], -122.4194);
      expect(json["forecast"]?["utc_offset_seconds"], -28800);
    });

    test('City should deserialize from JSON correctly', () {
      final json = {
        "name": "San Francisco",
        "country": "USA",
        "timezone": "America/Los_Angeles",
        "elevation": 16.0,
        "latitude": 37.7749,
        "longitude": -122.4194,
        "forecast": {
          "utc_offset_seconds": -28800,
          "current": {
            "time": "2024-11-27T12:00:00Z",
            "weather_code": 101,
            "temperature": {"value": 15.0, "unit": "C"},
            "apparent_temperature": {"value": 14.0, "unit": "C"},
            "wind_speed": {"value": 5.0, "unit": "m/s"},
            "wind_gusts": {"value": 8.0, "unit": "m/s"},
            "wind_direction": {"value": 180, "unit": "°"},
            "relative_humidity": {"value": 70, "unit": "%"},
            "surface_pressure": {"value": 1012.0, "unit": "hPa"},
            "rain": {"value": 0.1, "unit": "mm"},
            "precipitation": {"value": 0.2, "unit": "mm"},
            "cloud_cover": {"value": 50, "unit": "%"},
            "is_day": true,
          },
          "hourly": [],
          "daily": [],
        }
      };

      final city = City.fromJson(json);

      expect(city.name, "San Francisco");
      expect(city.country, "USA");
      expect(city.timezone, "America/Los_Angeles");
      expect(city.elevation, 16.0);
      expect(city.latitude, 37.7749);
      expect(city.longitude, -122.4194);
      expect(city.forecast?.utc_offset_seconds, -28800);
    });

    test('City should serialize to a JSON string correctly', () {
      const city = City(
        name: "San Francisco",
        country: "USA",
        timezone: "America/Los_Angeles",
        elevation: 16.0,
        latitude: 37.7749,
        longitude: -122.4194,
        forecast: null,
      );

      final serialized = city.serialize();
      expect(
        serialized,
        '{"name":"San Francisco","timezone":"America/Los_Angeles","elevation":16.0,"country":"USA","latitude":37.7749,"longitude":-122.4194,"forecast":null}',
      );
    });

    test('City should support equality comparison', () {
      const city1 = City(
        name: "San Francisco",
        country: "USA",
        timezone: "America/Los_Angeles",
        elevation: 16.0,
        latitude: 37.7749,
        longitude: -122.4194,
        forecast: null,
      );

      const city2 = City(
        name: "San Francisco",
        country: "USA",
        timezone: "America/Los_Angeles",
        elevation: 16.0,
        latitude: 37.7749,
        longitude: -122.4194,
        forecast: null,
      );

      expect(city1 == city2, true);
    });
  });
}
