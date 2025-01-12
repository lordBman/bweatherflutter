import 'package:bweather_repository/models/forecast.dart';
import 'package:flutter_test/flutter_test.dart';

// Assuming Forecast, Current, Hourly, Daily, and Value classes are imported here

void main() {
  group('Forecast tests', () {
    test('Forecast should serialize to JSON correctly', () {
      final forecast = Forecast(
        utc_offset_seconds: 3600,
        current: Current(
          time: DateTime.parse("2024-11-27T12:00:00Z"),
          weather_code: 101,
          temperature: const Value(value: 20.0, unit: "C"),
          apparent_temperature: const Value(value: 22.0, unit: "C"),
          wind_speed: const Value(value: 5.0, unit: "m/s"),
          wind_gusts: const Value(value: 8.0, unit: "m/s"),
          wind_direction: const Value(value: 180, unit: "°"),
          relative_humidity: const Value(value: 60, unit: "%"),
          surface_pressure: const Value(value: 1015.0, unit: "hPa"),
          rain: const Value(value: 0.2, unit: "mm"),
          precipitation: const Value(value: 0.4, unit: "mm"),
          cloud_cover: const Value(value: 50, unit: "%"),
          is_day: true,
        ),
        hourly: [
          Hourly(
            time: DateTime.parse("2024-11-27T13:00:00Z"),
            weather_code: 102,
            temperature: const Value(value: 21.0, unit: "C"),
            dew_point: const Value(value: 15.0, unit: "C"),
            apparent_temperature: const Value(value: 22.5, unit: "C"),
            rain: const Value(value: 0.3, unit: "mm"),
            relative_humidity: const Value(value: 55, unit: "%"),
            precipitation_probability: const Value(value: 20, unit: "%"),
          ),
        ],
        daily: [
          Daily(
            time: DateTime.parse("2024-11-27"),
            weather_code: 103,
            temperature_max: const Value(value: 25.0, unit: "C"),
            temperature_min: const Value(value: 15.0, unit: "C"),
            apparent_temperature_max: const Value(value: 26.0, unit: "C"),
            apparent_temperature_min: const Value(value: 14.0, unit: "C"),
          ),
        ],
      );

      final json = forecast.toJson();
      expect(json["utc_offset_seconds"], 3600);
      expect(json["current"]["temperature"], {"value": 20.0, "unit": "C"});
      expect(json["hourly"].length, 1);
      expect(json["daily"].length, 1);
      expect(json["hourly"][0]["weather_code"], 102);
    });

    test('Forecast should deserialize from JSON correctly', () {
      final json = {
        "utc_offset_seconds": 3600,
        "current": {
          "time": "2024-11-27T12:00:00Z",
          "weather_code": 101,
          "temperature": {"value": 20.0, "unit": "C"},
          "apparent_temperature": {"value": 22.0, "unit": "C"},
          "wind_speed": {"value": 5.0, "unit": "m/s"},
          "wind_gusts": {"value": 8.0, "unit": "m/s"},
          "wind_direction": {"value": 180, "unit": "°"},
          "relative_humidity": {"value": 60, "unit": "%"},
          "surface_pressure": {"value": 1015.0, "unit": "hPa"},
          "rain": {"value": 0.2, "unit": "mm"},
          "precipitation": {"value": 0.4, "unit": "mm"},
          "cloud_cover": {"value": 50, "unit": "%"},
          "is_day": true,
        },
        "hourly": [
          {
            "time": "2024-11-27T13:00:00Z",
            "weather_code": 102,
            "temperature": {"value": 21.0, "unit": "C"},
            "dew_point": {"value": 15.0, "unit": "C"},
            "apparent_temperature": {"value": 22.5, "unit": "C"},
            "rain": {"value": 0.3, "unit": "mm"},
            "relative_humidity": {"value": 55, "unit": "%"},
            "precipitation_probability": {"value": 20, "unit": "%"},
          },
        ],
        "daily": [
          {
            "time": "2024-11-27",
            "weather_code": 103,
            "temperature_max": {"value": 25.0, "unit": "C"},
            "temperature_min": {"value": 15.0, "unit": "C"},
            "apparent_temperature_max": {"value": 26.0, "unit": "C"},
            "apparent_temperature_min": {"value": 14.0, "unit": "C"},
          },
        ],
      };

      final forecast = Forecast.fromJson(json);
      expect(forecast.utc_offset_seconds, 3600);
      expect(forecast.current.temperature.value, 20.0);
      expect(forecast.hourly.length, 1);
      expect(forecast.daily.length, 1);
      expect(forecast.hourly[0].weather_code, 102);
    });

    test('Forecast should serialize to a JSON string correctly', () {
      final forecast = Forecast(
        utc_offset_seconds: 3600,
        current: Current(
          time: DateTime.parse("2024-11-27T12:00:00Z"),
          weather_code: 101,
          temperature: const Value(value: 20.0, unit: "C"),
          apparent_temperature: const Value(value: 22.0, unit: "C"),
          wind_speed: const Value(value: 5.0, unit: "m/s"),
          wind_gusts: const Value(value: 8.0, unit: "m/s"),
          wind_direction: const Value(value: 180, unit: "°"),
          relative_humidity: const Value(value: 60, unit: "%"),
          surface_pressure: const Value(value: 1015.0, unit: "hPa"),
          rain: const Value(value: 0.2, unit: "mm"),
          precipitation: const Value(value: 0.4, unit: "mm"),
          cloud_cover: const Value(value: 50, unit: "%"),
          is_day: true,
        ),
        hourly: [],
        daily: [],
      );

      final serialized = forecast.serialize();
      expect(
        serialized,
        '{"utc_offset_seconds":3600,"current":{"wind_speed":{"value":5.0,"unit":"m/s"},"wind_gusts":{"value":8.0,"unit":"m/s"},"wind_direction":{"value":180,"unit":"°"},"time":"2024-11-27 12:00:00.000Z","weather_code":101,"temperature":{"value":20.0,"unit":"C"},"surface_pressure":{"value":1015.0,"unit":"hPa"},"rain":{"value":0.2,"unit":"mm"},"relative_humidity":{"value":60,"unit":"%"},"is_day":true,"apparent_temperature":{"value":22.0,"unit":"C"},"precipitation":{"value":0.4,"unit":"mm"},"cloud_cover":{"value":50,"unit":"%"}},"hourly":[],"daily":[]}',
      );
    });

    test('Forecast should support equality comparison', () {
      final forecast1 = Forecast(
        utc_offset_seconds: 3600,
        current: Current(
          time: DateTime.parse("2024-11-27T12:00:00Z"),
          weather_code: 101,
          temperature: const Value(value: 20.0, unit: "C"),
          apparent_temperature: const Value(value: 22.0, unit: "C"),
          wind_speed: const Value(value: 5.0, unit: "m/s"),
          wind_gusts: const Value(value: 8.0, unit: "m/s"),
          wind_direction: const Value(value: 180, unit: "°"),
          relative_humidity: const Value(value: 60, unit: "%"),
          surface_pressure: const Value(value: 1015.0, unit: "hPa"),
          rain: const Value(value: 0.2, unit: "mm"),
          precipitation: const Value(value: 0.4, unit: "mm"),
          cloud_cover: const Value(value: 50, unit: "%"),
          is_day: true,
        ),
        hourly: [],
        daily: [],
      );

      final forecast2 = Forecast(
        utc_offset_seconds: 3600,
        current: forecast1.current,
        hourly: [],
        daily: [],
      );

      expect(forecast1 == forecast2, true);
    });
  });
}
