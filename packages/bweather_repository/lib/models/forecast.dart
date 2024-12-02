import 'dart:convert';

import 'package:bweather_open_meteo_api/util.dart';

import 'package:equatable/equatable.dart';

class Value<T> extends Equatable{
    final T value;
    final String unit;

    const Value({ required this.value, required this.unit });

    factory Value.fromJson(dynamic json) => Value<T>(value: json["value"], unit: json["unit"]);

    Map<String, dynamic> toJson() => { "value": value, "unit": unit };
    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [ value, unit ];
}

class Current extends Equatable{
    final Value<double> temperature, apparent_temperature, wind_speed,  wind_gusts, precipitation, rain, surface_pressure;
    final Value<int> wind_direction, cloud_cover, relative_humidity;
    final bool is_day;
    final int weather_code;

    final DateTime time;

    const Current({
        required this.wind_speed, required this.wind_gusts, required this.wind_direction, required this.time,
        required this.weather_code, required this.temperature, required this.surface_pressure, required this.rain,
        required this.relative_humidity, required this.is_day,
        required this.apparent_temperature, required this.cloud_cover, required this.precipitation
    });

    factory Current.fromJson(dynamic json) {
        return Current(
            wind_speed:  Value<double>.fromJson(json["wind_speed"]), wind_gusts: Value.fromJson(json["wind_gusts"]),
            wind_direction: Value<int>.fromJson(json["wind_direction"]), time: JsonParser.parseDate(json, "time"),
            weather_code: JsonParser.parseInt(json, "weather_code"), temperature: Value.fromJson(json["temperature"]),
            surface_pressure: Value<double>.fromJson(json["surface_pressure"]), rain: Value.fromJson(json["rain"]),
            relative_humidity: Value.fromJson(json["relative_humidity"]),
            is_day: JsonParser.parseBoolean(json, "is_day"), apparent_temperature: Value.fromJson(json["apparent_temperature"]),
            cloud_cover: Value<int>.fromJson(json["cloud_cover"]), precipitation: Value.fromJson(json["precipitation"])
        );
    }

    Map<String, dynamic> toJson() => {
        "wind_speed": wind_speed.toJson(), "wind_gusts": wind_gusts.toJson(), "wind_direction": wind_direction.toJson(),
        "time": time.toString(), "weather_code": weather_code, "temperature": temperature.toJson(), "surface_pressure": surface_pressure.toJson(),
        "rain": rain.toJson(), "relative_humidity": relative_humidity.toJson(), "is_day": is_day,
        "apparent_temperature": apparent_temperature.toJson(), "precipitation": precipitation.toJson(), "cloud_cover": cloud_cover.toJson()
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [
        temperature, relative_humidity, apparent_temperature, wind_speed,  wind_gusts, precipitation, rain, surface_pressure,
        wind_direction, cloud_cover, is_day, weather_code, time
    ];
}

class Hourly extends Equatable{
    final DateTime time;
    final Value<double> temperature, dew_point, apparent_temperature, rain;
    final Value<int> relative_humidity, precipitation_probability;
    final int weather_code;

    const Hourly({
        required this.time, required this.dew_point, required this.precipitation_probability,
        required this.weather_code, required this.temperature, required this.relative_humidity,
        required this.rain, required this.apparent_temperature
    });

    factory Hourly.fromJson(dynamic json) {
        return Hourly(
            apparent_temperature: Value<double>.fromJson(json["apparent_temperature"]), relative_humidity: Value<int>.fromJson(json["relative_humidity"]),
            rain: Value<double>.fromJson(json["rain"]), temperature: Value<double>.fromJson(json["temperature"]), weather_code: JsonParser.parseInt(json, "weather_code"),
            precipitation_probability: Value<int>.fromJson(json["precipitation_probability"]), dew_point: Value<double>.fromJson(json["dew_point"]),
            time: JsonParser.parseDate(json, "time")
        );
    }

    Map<String, dynamic> toJson() => {
        "time": time.toString(), "weather_code": weather_code, "temperature": temperature.toJson(),
        "rain": rain.toJson(), "relative_humidity": relative_humidity.toJson(), "apparent_temperature": apparent_temperature.toJson(),
        "precipitation_probability": precipitation_probability.toJson(), "dew_point": dew_point.toJson(),
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [
        time, temperature, dew_point, apparent_temperature, rain, relative_humidity, precipitation_probability, weather_code
    ];
}


class Daily extends Equatable{
    final DateTime time;
    final int weather_code;
    final Value<double> temperature_max, temperature_min, apparent_temperature_max, apparent_temperature_min;

    const Daily({
        required this.temperature_max, required this.apparent_temperature_min,
        required this.apparent_temperature_max, required this.temperature_min, required this.time,
        required this.weather_code
    });

    factory Daily.fromJson(dynamic json) {
        return Daily(
            apparent_temperature_min: Value<double>.fromJson(json["apparent_temperature_min"]), apparent_temperature_max: Value<double>.fromJson(json["apparent_temperature_max"]),
            weather_code: JsonParser.parseInt(json, "weather_code"),
            temperature_min: Value<double>.fromJson(json["temperature_min"]), temperature_max: Value<double>.fromJson(json["temperature_max"]),
            time: JsonParser.parseDate(json, "time"),
        );
    }

    Map<String, dynamic> toJson() => {
        "time": time.toString(), "weather_code": weather_code, "apparent_temperature_min": apparent_temperature_min.toJson(), "apparent_temperature_max": apparent_temperature_max.toJson(),
        "temperature_min": temperature_min.toJson(), "temperature_max": temperature_max.toJson(),
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [
        temperature_max, temperature_min, apparent_temperature_max, apparent_temperature_min,
        weather_code, time
    ];
}

class Forecast extends Equatable{
    final int utc_offset_seconds;

    final Current current;
    final List<Hourly> hourly;
    final List<Daily> daily;

    const Forecast({
        required this.utc_offset_seconds,
        required this.current, required this.hourly, required this.daily,
    });

    factory Forecast.fromJson(dynamic json) {
        return Forecast(
            utc_offset_seconds: JsonParser.parseInt(json, "utc_offset_seconds"),
            current: Current.fromJson(json["current"]),
            hourly: (json["hourly"] as List).map((element)=> Hourly.fromJson(element)).toList(),
            daily: (json["daily"] as List).map((element)=> Daily.fromJson(element)).toList() 
        );
    }

    Map<String, dynamic> toJson() => {
        "utc_offset_seconds": utc_offset_seconds,
        "current": current.toJson(),
        "hourly": hourly.map((element)=> element.toJson()).toList(),
        "daily": daily.map((element) => element.toJson()).toList()
    };

    String serialize() => jsonEncode(toJson());
    
    @override
    List<Object?> get props => [current, utc_offset_seconds, hourly, daily];
}