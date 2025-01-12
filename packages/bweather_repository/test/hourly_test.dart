import 'dart:convert';
import 'package:bweather_repository/models/forecast.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:equatable/equatable.dart';

// Assuming Value and Hourly classes are imported here

void main() {
  group('Hourly tests', () {
    test('Hourly should serialize to JSON correctly', () {
      final hourly = Hourly(
        time: DateTime.parse("2024-11-27 15:00:00Z"),
        dew_point: const Value(value: 10.5, unit: "C"),
        precipitation_probability: const Value(value: 40, unit: "%"),
        weather_code: 123,
        temperature: const Value(value: 25.0, unit: "C"),
        relative_humidity: const Value(value: 50, unit: "%"),
        rain: const Value(value: 0.5, unit: "mm"),
        apparent_temperature: const Value(value: 27.0, unit: "C"),
      );

      final json = hourly.toJson();
      expect(json["time"], "2024-11-27 15:00:00.000Z");
      expect(json["temperature"], {"value": 25.0, "unit": "C"});
      expect(json["dew_point"], {"value": 10.5, "unit": "C"});
      expect(json["precipitation_probability"], {"value": 40, "unit": "%"});
    });

    test('Hourly should deserialize from JSON correctly', () {
      final json = {
        "time": "2024-11-27T15:00:00Z",
        "dew_point": {"value": 10.5, "unit": "C"},
        "precipitation_probability": {"value": 40, "unit": "%"},
        "weather_code": 123,
        "temperature": {"value": 25.0, "unit": "C"},
        "relative_humidity": {"value": 50, "unit": "%"},
        "rain": {"value": 0.5, "unit": "mm"},
        "apparent_temperature": {"value": 27.0, "unit": "C"},
      };

      final hourly = Hourly.fromJson(json);
      expect(hourly.time, DateTime.parse("2024-11-27T15:00:00Z"));
      expect(hourly.dew_point.value, 10.5);
      expect(hourly.dew_point.unit, "C");
      expect(hourly.temperature.value, 25.0);
      expect(hourly.rain.value, 0.5);
      expect(hourly.precipitation_probability.value, 40);
    });

    test('Hourly should serialize to a JSON string correctly', () {
      final hourly = Hourly(
        time: DateTime.parse("2024-11-27T15:00:00Z"),
        dew_point: const Value(value: 10.5, unit: "C"),
        precipitation_probability: const Value(value: 40, unit: "%"),
        weather_code: 123,
        temperature: const Value(value: 25.0, unit: "C"),
        relative_humidity: const Value(value: 50, unit: "%"),
        rain: const Value(value: 0.5, unit: "mm"),
        apparent_temperature: const Value(value: 27.0, unit: "C"),
      );

      final serialized = hourly.serialize();
      expect(
        serialized,
        '{"time":"2024-11-27 15:00:00.000Z","weather_code":123,"temperature":{"value":25.0,"unit":"C"},"rain":{"value":0.5,"unit":"mm"},"relative_humidity":{"value":50,"unit":"%"},"apparent_temperature":{"value":27.0,"unit":"C"},"precipitation_probability":{"value":40,"unit":"%"},"dew_point":{"value":10.5,"unit":"C"}}',
      );
    });

    test('Hourly should support equality comparison', () {
      final hourly1 = Hourly(
        time: DateTime.parse("2024-11-27T15:00:00Z"),
        dew_point: const Value(value: 10.5, unit: "C"),
        precipitation_probability: const Value(value: 40, unit: "%"),
        weather_code: 123,
        temperature: const Value(value: 25.0, unit: "C"),
        relative_humidity: const Value(value: 50, unit: "%"),
        rain: const Value(value: 0.5, unit: "mm"),
        apparent_temperature: const Value(value: 27.0, unit: "C"),
      );

      final hourly2 = Hourly(
        time: DateTime.parse("2024-11-27T15:00:00Z"),
        dew_point: const Value(value: 10.5, unit: "C"),
        precipitation_probability: const Value(value: 40, unit: "%"),
        weather_code: 123,
        temperature: const Value(value: 25.0, unit: "C"),
        relative_humidity: const Value(value: 50, unit: "%"),
        rain: const Value(value: 0.5, unit: "mm"),
        apparent_temperature: const Value(value: 27.0, unit: "C"),
      );

      final hourly3 = Hourly(
        time: DateTime.parse("2024-11-27T15:00:00Z"),
        dew_point: const Value(value: 15.0, unit: "C"), // Different dew point
        precipitation_probability: const Value(value: 40, unit: "%"),
        weather_code: 123,
        temperature: const Value(value: 25.0, unit: "C"),
        relative_humidity: const Value(value: 50, unit: "%"),
        rain: const Value(value: 0.5, unit: "mm"),
        apparent_temperature: const Value(value: 27.0, unit: "C"),
      );

      expect(hourly1 == hourly2, true); // Equal objects
      expect(hourly1 == hourly3, false); // Different dew point
    });
  });
}
