import 'dart:convert';

import 'package:bweather_open_meteo_api/util.dart';

import 'package:equatable/equatable.dart';

class Value<T>{
    final T value;
    final String unit;

    Value({ required this.value, required this.unit });

    factory Value.fromJson(dynamic json) => Value<T>(value: json["value"], unit: json["unit"]);

    Map toJson() => { "value": value, "unit": unit };
    String serialize() => jsonEncode(toJson());
}

class Current{
    Value<double> temperature, relative_humidity, apparent_temperature, wind_speed,  wind_gusts, precipitation, rain, surface_pressure;
    Value<int> wind_direction, cloud_cover;
    bool is_day;
    int weather_code;

    DateTime time;

    Current({
        required this.wind_speed, required this.wind_gusts, required this.wind_direction, required this.time,
        required this.weather_code, required this.temperature, required this.surface_pressure, required this.rain,
        required this.relative_humidity, required this.is_day,
        required this.apparent_temperature, required this.cloud_cover, required this.precipitation
    });

    factory Current.fromJson(dynamic json) {
        return Current(
            wind_speed:  Value.fromJson(json["wind_speed"]), wind_gusts: Value.fromJson(json["wind_gusts"]),
            wind_direction: Value.fromJson(json["wind_direction"]), time: JsonParser.parseDate(json, "time"),
            weather_code: JsonParser.parseInt(json, "weather_code"), temperature: Value.fromJson(json["temperature"]),
            surface_pressure: Value.fromJson(json["surface_pressure"]), rain: Value.fromJson(json["rain"]),
            relative_humidity: Value.fromJson(json["relative_humidity"]),
            is_day: JsonParser.parseBoolean(json, "is_day"), apparent_temperature: Value.fromJson(json["apparent_temperature"]),
            cloud_cover: Value.fromJson(json["cloud_cover"]), precipitation: Value.fromJson(json["precipitation"])
        );
    }

    Map toJson() => {
        "wind_speed": wind_speed.toJson(), "wind_gusts": wind_gusts.toJson(), "wind_direction": wind_direction.toJson(),
        "time": time, "weather_code": weather_code, "temperature": temperature.toJson(), "surface_pressure": surface_pressure.toJson(),
        "rain": rain.toJson(), "relative_humidity": relative_humidity.toJson(), "is_day": is_day,
        "apparent_temperature": apparent_temperature.toJson(), "precipitation": precipitation.toJson(), "cloud_cover": cloud_cover.toJson()
    };

    String serialize() => jsonEncode(toJson());
}

class Hourly{
    DateTime time;
    Value<double> temperature, dew_point, apparent_temperature, rain;
    Value<int> relative_humidity, precipitation_probability;
    int weather_code;

    Hourly({
        required this.time, required this.dew_point, required this.precipitation_probability,
        required this.weather_code, required this.temperature, required this.relative_humidity,
        required this.rain, required this.apparent_temperature
    });

    factory Hourly.fromJson(dynamic json) {
        return Hourly(
            apparent_temperature: Value.fromJson(json["apparent_temperature"]), relative_humidity: Value.fromJson(json["relative_humidity"]),
            rain: Value.fromJson(json["rain"]), temperature: Value.fromJson(json["temperature"]), weather_code: JsonParser.parseInt(json, "weather_code"),
            precipitation_probability: Value.fromJson(json["precipitation_probability"]), dew_point: Value.fromJson(json["dew_point"]),
            time: JsonParser.parseDate(json, "time")
        );
    }

    Map toJson() => {
        "time": time, "weather_code": weather_code, "temperature": temperature.toJson(),
        "rain": rain.toJson(), "relative_humidity": relative_humidity.toJson(), "apparent_temperature": apparent_temperature.toJson(),
        "precipitation_probability": precipitation_probability.toJson(), "dew_point": dew_point.toJson(),
    };

    String serialize() => jsonEncode(toJson());
}


class Daily{
    DateTime time;
    int weather_code;
    Value<double> temperature_max, temperature_min, apparent_temperature_max, apparent_temperature_min;

    Daily({
        required this.temperature_max, required this.apparent_temperature_min,
        required this.apparent_temperature_max, required this.temperature_min, required this.time,
        required this.weather_code
    });

    factory Daily.fromJson(dynamic json) {
        return Daily(
            apparent_temperature_min: Value.fromJson(json["apparent_temperature_min"]), apparent_temperature_max: Value.fromJson(json["apparent_temperature_max"]),
            weather_code: JsonParser.parseInt(json, "weather_code"),
            temperature_min: Value.fromJson(json["temperature_min"]), temperature_max: Value.fromJson(json["temperature_max"]),
            time: JsonParser.parseDate(json, "time"),
        );
    }

    Map toJson() => {
        "time": time, "weather_code": weather_code, "apparent_temperature_min": apparent_temperature_min, "apparent_temperature_max": apparent_temperature_max,
        "temperature_min": temperature_min, "temperature_max": temperature_max,
    };

    String serialize() => jsonEncode(toJson());
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
    List<Object?> get props => [current];
}