import 'dart:convert';

import 'package:bweather_open_meteo_api/util.dart';
import 'package:equatable/equatable.dart';

class CurrentUnits extends Equatable{
    final String temperature_2m, relative_humidity_2m, apparent_temperature, rain, pressure_msl;
    final String surface_pressure, wind_speed_10m, wind_direction_10m, wind_gusts_10m, precipitation, cloud_cover;

    const CurrentUnits({
        required this.apparent_temperature, required this.pressure_msl,
        required this.rain, required this.relative_humidity_2m, required this.surface_pressure, required this.temperature_2m,
        required this.wind_direction_10m, required this.wind_gusts_10m,
        required this.wind_speed_10m, required this.cloud_cover, required this.precipitation
    });

    factory CurrentUnits.fromJson(dynamic json) {
        return CurrentUnits(
            apparent_temperature: json["apparent_temperature"].toString(),
            pressure_msl: json["pressure_msl"].toString(), rain: json["rain"].toString(),
            relative_humidity_2m: json["relative_humidity_2m"].toString(), surface_pressure: json["surface_pressure"].toString(),
            temperature_2m: json["temperature_2m"].toString(),
            wind_direction_10m: json["wind_direction_10m"].toString(), wind_gusts_10m: json["wind_gusts_10m"].toString(),
            wind_speed_10m: json["wind_speed_10m"].toString(), precipitation: json["precipitation"], cloud_cover: json["cloud_cover"]
        );
    }

    Map<String, dynamic> toJson() => {
        "apparent_temperature" : apparent_temperature, "surface_pressure": surface_pressure,
        "pressure_msl": pressure_msl, "rain": rain, "relative_humidity_2m": relative_humidity_2m, "temperature_2m": temperature_2m,
        "wind_direction_10m": wind_direction_10m, "wind_gusts_10m": wind_gusts_10m,
        "wind_speed_10m": wind_speed_10m, "precipitation": precipitation, "cloud_cover": cloud_cover
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [
        temperature_2m, relative_humidity_2m, apparent_temperature, rain, pressure_msl,
        surface_pressure, wind_speed_10m, wind_direction_10m, wind_gusts_10m, precipitation, cloud_cover
    ];
}

class Current extends Equatable{
    final DateTime time;
    final int is_day, weather_code, relative_humidity_2m, wind_direction_10m,cloud_cover;
    final double temperature_2m, apparent_temperature, precipitation, rain, pressure_msl, surface_pressure, wind_speed_10m;
    final double wind_gusts_10m;

    const Current({
        required this.wind_speed_10m, required this.wind_gusts_10m, required this.wind_direction_10m, required this.time,
        required this.weather_code, required this.temperature_2m, required this.surface_pressure, required this.rain,
        required this.relative_humidity_2m, required this.pressure_msl, required this.is_day,
        required this.apparent_temperature, required this.cloud_cover, required this.precipitation
    });

    factory Current.fromJson(dynamic json) {
        return Current(
            wind_speed_10m: JsonParser.parseDouble(json, "wind_speed_10m"), wind_gusts_10m: JsonParser.parseDouble(json, "wind_gusts_10m"),
            wind_direction_10m: JsonParser.parseInt(json, "wind_direction_10m"), time: JsonParser.parseDate(json, "time"),
            weather_code: JsonParser.parseInt(json, "weather_code"), temperature_2m: JsonParser.parseDouble(json, "temperature_2m"),
            surface_pressure: JsonParser.parseDouble(json, "surface_pressure"), rain: JsonParser.parseDouble(json, "rain"),
            relative_humidity_2m: JsonParser.parseInt(json, "relative_humidity_2m"), pressure_msl: JsonParser.parseDouble(json, "pressure_msl"),
            is_day: JsonParser.parseInt(json, "is_day"), apparent_temperature: JsonParser.parseDouble(json, "apparent_temperature"),
            cloud_cover: JsonParser.parseInt(json, "cloud_cover"), precipitation: JsonParser.parseDouble(json, "precipitation")
        );
    }

    Map<String, dynamic> toJson() => {
        "wind_speed_10m": wind_speed_10m, "wind_gusts_10m": wind_gusts_10m, "wind_direction_10m": wind_direction_10m,
        "time": time.toString(), "weather_code": weather_code, "temperature_2m": temperature_2m, "surface_pressure": surface_pressure,
        "rain": rain, "relative_humidity_2m": relative_humidity_2m, "pressure_msl": pressure_msl, "is_day": is_day,
        "apparent_temperature": apparent_temperature, "precipitation": precipitation, "cloud_cover": cloud_cover
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [
        time,
        temperature_2m, relative_humidity_2m, apparent_temperature, precipitation, rain, pressure_msl, surface_pressure, wind_speed_10m,
        weather_code, wind_gusts_10m, is_day, wind_direction_10m,cloud_cover
    ];
}

class HourlyUnits extends Equatable{
    final String temperature_2m, relative_humidity_2m, dew_point_2m, apparent_temperature;
    final String precipitation_probability, rain;

    const HourlyUnits({
        required this.apparent_temperature, required this.relative_humidity_2m, required this.rain,
        required this.temperature_2m, required this.precipitation_probability,
        required this.dew_point_2m
    });

    factory HourlyUnits.fromJson(dynamic json) {
        return HourlyUnits(
            apparent_temperature: JsonParser.parseString(json, "apparent_temperature"), relative_humidity_2m: JsonParser.parseString(json, "relative_humidity_2m"),
            rain: JsonParser.parseString(json, "rain"), temperature_2m: JsonParser.parseString(json, "temperature_2m"),
            precipitation_probability: JsonParser.parseString(json, "precipitation_probability"), dew_point_2m: JsonParser.parseString(json, "dew_point_2m")
        );
    }

    Map<String, dynamic> toJson() => {
        "temperature_2m": temperature_2m,
        "rain": rain, "relative_humidity_2m": relative_humidity_2m, "apparent_temperature": apparent_temperature,
        "precipitation_probability": precipitation_probability, "dew_point_2m": dew_point_2m,
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [
        temperature_2m, dew_point_2m, apparent_temperature, rain,
        relative_humidity_2m, precipitation_probability
    ];
}

class Hourly extends Equatable{
    final List<DateTime> time;
    final List<double> temperature_2m, dew_point_2m, apparent_temperature, rain;
    final List<int> relative_humidity_2m, precipitation_probability, weather_code;

    const Hourly({
        required this.time, required this.dew_point_2m, required this.precipitation_probability,
        required this.weather_code, required this.temperature_2m, required this.relative_humidity_2m,
        required this.rain, required this.apparent_temperature
    });

    factory Hourly.fromJson(dynamic json) {
        return Hourly(
            apparent_temperature: JsonParser.parseDoubleList(json, "apparent_temperature"), relative_humidity_2m: JsonParser.parseIntList(json, "relative_humidity_2m"),
            rain: JsonParser.parseDoubleList(json, "rain"), temperature_2m: JsonParser.parseDoubleList(json, "temperature_2m"), weather_code: JsonParser.parseIntList(json, "weather_code"),
            precipitation_probability: JsonParser.parseIntList(json, "precipitation_probability"), dew_point_2m: JsonParser.parseDoubleList(json, "dew_point_2m"),
            time: JsonParser.parseDateList(json, "time")
        );
    }

    Map<String, dynamic> toJson() => {
        "time": time.map((element)=> element.toString()).toList(), "weather_code": weather_code, "temperature_2m": temperature_2m,
        "rain": rain, "relative_humidity_2m": relative_humidity_2m, "apparent_temperature": apparent_temperature,
        "precipitation_probability": precipitation_probability, "dew_point_2m": dew_point_2m,
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [
        time, temperature_2m, dew_point_2m, apparent_temperature, rain,
        relative_humidity_2m, precipitation_probability, weather_code
    ];
}

class DailyUnits extends Equatable{
    final String temperature_2m_max, temperature_2m_min, apparent_temperature_max, apparent_temperature_min;
    final String precipitation_sum, rain_sum, wind_speed_10m_max, wind_gusts_10m_max;

    const DailyUnits({
        required this.apparent_temperature_max,
        required this.apparent_temperature_min, required this.precipitation_sum, required this.temperature_2m_max,
        required this.rain_sum, required this.temperature_2m_min, required this.wind_gusts_10m_max,
        required this.wind_speed_10m_max
    });

    factory DailyUnits.fromJson(dynamic json) {
        return DailyUnits(
            apparent_temperature_min: JsonParser.parseString(json, "apparent_temperature_min"), apparent_temperature_max: JsonParser.parseString(json, "apparent_temperature_max"),
            temperature_2m_min: JsonParser.parseString(json, "temperature_2m_min"), temperature_2m_max: JsonParser.parseString(json, "temperature_2m_max"),
            precipitation_sum: JsonParser.parseString(json, "precipitation_sum"), rain_sum: JsonParser.parseString(json, "rain_sum"),
            wind_gusts_10m_max: JsonParser.parseString(json, "wind_gusts_10m_max"), wind_speed_10m_max: JsonParser.parseString(json, "wind_speed_10m_max")
        );
    }

    Map<String, dynamic> toJson() => {
        "apparent_temperature_min": apparent_temperature_min, "apparent_temperature_max": apparent_temperature_max,
        "temperature_2m_min": temperature_2m_min, "temperature_2m_max": temperature_2m_max,
        "precipitation_sum": precipitation_sum, "rain_sum": rain_sum, "wind_gusts_10m_max": wind_gusts_10m_max, "wind_speed_10m_max": wind_speed_10m_max
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [
        temperature_2m_max, temperature_2m_min, apparent_temperature_max, apparent_temperature_min,
        precipitation_sum, rain_sum, wind_speed_10m_max, wind_gusts_10m_max
    ];
}

class Daily extends Equatable{
    final List<DateTime> time, sunrise, sunset;
    final List<int> weather_code;
    final List<double> temperature_2m_max, temperature_2m_min, apparent_temperature_max, apparent_temperature_min;
    final List<double> precipitation_sum, rain_sum, wind_speed_10m_max, wind_gusts_10m_max;

    const Daily({
        required this.wind_speed_10m_max, required this.wind_gusts_10m_max, required this.sunset, required this.rain_sum,
        required this.temperature_2m_max, required this.precipitation_sum, required this.apparent_temperature_min,
        required this.sunrise, required this.apparent_temperature_max, required this.temperature_2m_min, required this.time,
        required this.weather_code
    });

    factory Daily.fromJson(dynamic json) {
        return Daily(
            apparent_temperature_min: JsonParser.parseDoubleList(json, "apparent_temperature_min"), apparent_temperature_max: JsonParser.parseDoubleList(json, "apparent_temperature_max"),
            sunrise: JsonParser.parseDateList(json, "sunrise"), sunset: JsonParser.parseDateList(json, "sunset"), weather_code: JsonParser.parseIntList(json, "weather_code"),
            temperature_2m_min: JsonParser.parseDoubleList(json, "temperature_2m_min"), temperature_2m_max: JsonParser.parseDoubleList(json, "temperature_2m_max"),
            time: JsonParser.parseDateList(json, "time"), precipitation_sum: JsonParser.parseDoubleList(json, "precipitation_sum"), rain_sum: JsonParser.parseDoubleList(json, "rain_sum"),
            wind_gusts_10m_max: JsonParser.parseDoubleList(json, "wind_gusts_10m_max"), wind_speed_10m_max: JsonParser.parseDoubleList(json, "wind_speed_10m_max")
        );
    }

    Map<String, dynamic> toJson() => {
        "time": time.map((element)=> element.toString()).toList(), "weather_code": weather_code, "apparent_temperature_min": apparent_temperature_min, "apparent_temperature_max": apparent_temperature_max,
        "sunset": sunset.map((element)=> element.toString()).toList(), "sunrise": sunrise.map((element)=> element.toString()).toList(), "temperature_2m_min": temperature_2m_min, "temperature_2m_max": temperature_2m_max,
        "precipitation_sum": precipitation_sum, "rain_sum": rain_sum, "wind_gusts_10m_max": wind_gusts_10m_max, "wind_speed_10m_max": wind_speed_10m_max
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [
        temperature_2m_max, temperature_2m_min, apparent_temperature_max, apparent_temperature_min,
        precipitation_sum, rain_sum, wind_speed_10m_max, wind_gusts_10m_max, time, sunrise, sunset,
        weather_code
    ];
}

class Result extends Equatable{
    final double latitude, longitude, elevation;
    final int utc_offset_seconds;
    final String timezone, timezone_abbreviation;

    final CurrentUnits current_units;
    final Current current;

    final HourlyUnits hourly_units;
    final Hourly hourly;

    final DailyUnits daily_units;
    final Daily daily;

    const Result({
        required this.latitude, required this.longitude, required this.elevation,
        required this.timezone, required this.timezone_abbreviation, required this.utc_offset_seconds,
        required this.current_units, required this.current,
        required this.hourly_units, required this.hourly,
        required this.daily_units, required this.daily,
    });

    factory Result.fromJson(dynamic json) {
        return Result(
            latitude: JsonParser.parseDouble(json, "latitude"), longitude: JsonParser.parseDouble(json, "longitude"),
            elevation: JsonParser.parseDouble(json, "elevation"), timezone: JsonParser.parseString(json, "timezone"),
            timezone_abbreviation: JsonParser.parseString(json, "timezone_abbreviation"),
            utc_offset_seconds: JsonParser.parseInt(json, "utc_offset_seconds"),
            current_units: CurrentUnits.fromJson(json["current_units"]), current: Current.fromJson(json["current"]),
            hourly_units: HourlyUnits.fromJson(json["hourly_units"]), hourly: Hourly.fromJson(json["hourly"]),
            daily_units: DailyUnits.fromJson(json["daily_units"]), daily: Daily.fromJson(json["daily"])
        );
    }

    Map<String, dynamic> toJson() => {
        "latitude": latitude, "longitude": longitude, "elevation": elevation,
        "timezone": timezone, "timezone_abbreviation": timezone_abbreviation, "utc_offset_seconds": utc_offset_seconds,
        "current_units": current_units.toJson(), "current": current.toJson(), "hourly_units": hourly_units.toJson(), "hourly": hourly.toJson(),
        "daily_units": daily_units.toJson(), "daily": daily.toJson()
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [
        latitude, longitude, elevation, timezone, timezone_abbreviation, utc_offset_seconds,
        current, current_units, daily_units, daily, hourly, hourly_units
    ];
}