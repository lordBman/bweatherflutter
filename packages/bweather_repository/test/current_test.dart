import 'dart:convert';

import 'package:bweather_repository/models/forecast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Current', () {
    test('Current should deserialize from JSON correctly', () {
      final json = {
        "wind_speed": {"value": 15.0, "unit": "km/h"},
        "wind_gusts": {"value": 20.0, "unit": "km/h"},
        "wind_direction": {"value": 90, "unit": "degrees"},
        "time": "2024-11-27T10:00:00Z",
        "weather_code": 123,
        "temperature": {"value": 25.0, "unit": "C"},
        "surface_pressure": {"value": 1013.0, "unit": "hPa"},
        "rain": {"value": 0.0, "unit": "mm"},
        "relative_humidity": {"value": 50, "unit": "%"},
        "is_day": true,
        "apparent_temperature": {"value": 27.0, "unit": "C"},
        "cloud_cover": {"value": 20, "unit": "%"},
        "precipitation": {"value": 0.0, "unit": "mm"},
      };
      final current = Current.fromJson(json);
      expect(current.temperature.value, 25.0);
      expect(current.temperature.unit, "C");
      expect(current.time, DateTime.parse("2024-11-27T10:00:00Z"));
      expect(current.is_day, true);
      expect(current.weather_code, 123);
    });

    test('Current should support equality comparison', () {
      final current1 = Current(
        wind_speed: const Value(value: 15.0, unit: "km/h"),
        wind_gusts: const Value(value: 20.0, unit: "km/h"),
        wind_direction: const Value(value: 90, unit: "degrees"),
        time: DateTime.parse("2024-11-27T10:00:00Z"),
        weather_code: 123,
        temperature: const Value(value: 25.0, unit: "C"),
        surface_pressure: const Value(value: 1013.0, unit: "hPa"),
        rain: const Value(value: 0.0, unit: "mm"),
        relative_humidity: const Value(value: 50, unit: "%"),
        is_day: true,
        apparent_temperature: const Value(value: 27.0, unit: "C"),
        cloud_cover: const Value(value: 20, unit: "%"),
        precipitation: const Value(value: 0.0, unit: "mm"),
      );

      final current2 = Current(
        wind_speed: const Value(value: 15.0, unit: "km/h"),
        wind_gusts: const Value(value: 20.0, unit: "km/h"),
        wind_direction: const Value(value: 90, unit: "degrees"),
        time: DateTime.parse("2024-11-27T10:00:00Z"),
        weather_code: 123,
        temperature: const Value(value: 25.0, unit: "C"),
        surface_pressure: const Value(value: 1013.0, unit: "hPa"),
        rain: const Value(value: 0.0, unit: "mm"),
        relative_humidity: const Value(value: 50, unit: "%"),
        is_day: true,
        apparent_temperature: const Value(value: 27.0, unit: "C"),
        cloud_cover: const Value(value: 20, unit: "%"),
        precipitation: const Value(value: 0.0, unit: "mm"),
      );

      expect(current1 == current2, true);
    });
  });
}