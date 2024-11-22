import 'dart:convert';

import 'package:bweather_open_meteo_api/util.dart';

class CurrentUnits{
    String time, interval, temperature_2m, relative_humidity_2m, apparent_temperature, is_day, rain, weather_code, pressure_msl;
    String surface_pressure, wind_speed_10m, wind_direction_10m, wind_gusts_10m, precipitation, cloud_cover;

    CurrentUnits({
        required this.apparent_temperature, required this.interval, required this.is_day, required this.pressure_msl,
        required this.rain, required this.relative_humidity_2m, required this.surface_pressure, required this.temperature_2m,
        required this.time, required this.weather_code, required this.wind_direction_10m, required this.wind_gusts_10m,
        required this.wind_speed_10m, required this.cloud_cover, required this.precipitation
    });

    factory CurrentUnits.fromJson(dynamic json) {
        return CurrentUnits(
            apparent_temperature: json["apparent_temperature"].toString(), interval: json["interval"].toString(),
            is_day: json["is_day"] ?? "", pressure_msl: json["pressure_msl"].toString(), rain: json["rain"].toString(),
            relative_humidity_2m: json["relative_humidity_2m"].toString(), surface_pressure: json["surface_pressure"].toString(),
            temperature_2m: json["temperature_2m"].toString(), time: json["time"].toString(), weather_code: json["weather_code"].toString(),
            wind_direction_10m: json["wind_direction_10m"].toString(), wind_gusts_10m: json["wind_gusts_10m"].toString(),
            wind_speed_10m: json["wind_speed_10m"].toString(), precipitation: json["precipitation"], cloud_cover: json["cloud_cover"]
        );
    }

    Map toJson() => {
        "apparent_temperature" : apparent_temperature, "interval" : interval, "is_day": is_day, "surface_pressure": surface_pressure,
        "pressure_msl": pressure_msl, "rain": rain, "relative_humidity_2m": relative_humidity_2m, "temperature_2m": temperature_2m,
        "time": time, "weather_code": weather_code, "wind_direction_10m": wind_direction_10m, "wind_gusts_10m": wind_gusts_10m,
        "wind_speed_10m": wind_speed_10m, "precipitation": precipitation, "cloud_cover": cloud_cover
    };

    String serialize() => jsonEncode(toJson());
}

class Current{
    DateTime time;
    int interval, is_day, weather_code, wind_direction_10m,cloud_cover;
    double temperature_2m, relative_humidity_2m, apparent_temperature, precipitation, rain, pressure_msl, surface_pressure, wind_speed_10m;
    double wind_gusts_10m;

    Current({
        required this.wind_speed_10m, required this.wind_gusts_10m, required this.wind_direction_10m, required this.time,
        required this.weather_code, required this.temperature_2m, required this.surface_pressure, required this.rain,
        required this.relative_humidity_2m, required this.pressure_msl, required this.is_day, required this.interval,
        required this.apparent_temperature, required this.cloud_cover, required this.precipitation
    });

    factory Current.fromJson(dynamic json) {
        return Current(
            wind_speed_10m: JsonParser.parseDouble(json, "wind_speed_10m"), wind_gusts_10m: JsonParser.parseDouble(json, "wind_gusts_10m"),
            wind_direction_10m: JsonParser.parseInt(json, "wind_direction_10m"), time: JsonParser.parseDate(json, "time"),
            weather_code: JsonParser.parseInt(json, "weather_code"), temperature_2m: JsonParser.parseDouble(json, "temperature_2m"),
            surface_pressure: JsonParser.parseDouble(json, "surface_pressure"), rain: JsonParser.parseDouble(json, "rain"),
            relative_humidity_2m: JsonParser.parseDouble(json, "relative_humidity_2m"), pressure_msl: JsonParser.parseDouble(json, "pressure_msl"),
            is_day: JsonParser.parseInt(json, "is_day"), interval: JsonParser.parseInt(json, "interval"), apparent_temperature: JsonParser.parseDouble(json, "apparent_temperature"),
            cloud_cover: JsonParser.parseInt(json, "cloud_cover"), precipitation: JsonParser.parseDouble(json, "precipitation")
        );
    }

    Map toJson() => {
        "wind_speed_10m": wind_speed_10m, "wind_gusts_10m": wind_gusts_10m, "wind_direction_10m": wind_direction_10m,
        "time": time, "weather_code": weather_code, "temperature_2m": temperature_2m, "surface_pressure": surface_pressure,
        "rain": rain, "relative_humidity_2m": relative_humidity_2m, "pressure_msl": pressure_msl, "is_day": is_day,
        "interval": interval, "apparent_temperature": apparent_temperature, "precipitation": precipitation, "cloud_cover": cloud_cover
    };

    String serialize() => jsonEncode(toJson());
}

class HourlyUnits {
    String time, temperature_2m, relative_humidity_2m, dew_point_2m, apparent_temperature;
    String precipitation_probability, rain, weather_code;

    HourlyUnits({
        required this.apparent_temperature, required this.relative_humidity_2m, required this.rain,
        required this.temperature_2m, required this.weather_code, required this.precipitation_probability,
        required this.dew_point_2m, required this.time
    });

    factory HourlyUnits.fromJson(dynamic json) {
        return HourlyUnits(
            apparent_temperature: JsonParser.parseString(json, "apparent_temperature"), relative_humidity_2m: JsonParser.parseString(json, "relative_humidity_2m"),
            rain: JsonParser.parseString(json, "rain"), temperature_2m: JsonParser.parseString(json, "temperature_2m"), weather_code: JsonParser.parseString(json, "weather_code"),
            precipitation_probability: JsonParser.parseString(json, "precipitation_probability"), dew_point_2m: JsonParser.parseString(json, "dew_point_2m"),
            time: JsonParser.parseString(json, "time")
        );
    }

    Map toJson() => {
        "time": time, "weather_code": weather_code, "temperature_2m": temperature_2m,
        "rain": rain, "relative_humidity_2m": relative_humidity_2m, "apparent_temperature": apparent_temperature,
        "precipitation_probability": precipitation_probability, "dew_point_2m": dew_point_2m,
    };

    String serialize() => jsonEncode(toJson());
}

class Hourly{
    List<DateTime> time;
    List<double> temperature_2m, dew_point_2m, apparent_temperature, rain;
    List<int> relative_humidity_2m, precipitation_probability, weather_code;

    Hourly({
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

    Map toJson() => {
        "time": time, "weather_code": weather_code, "temperature_2m": temperature_2m,
        "rain": rain, "relative_humidity_2m": relative_humidity_2m, "apparent_temperature": apparent_temperature,
        "precipitation_probability": precipitation_probability, "dew_point_2m": dew_point_2m,
    };

    String serialize() => jsonEncode(toJson());
}

class DailyUnits{
    String time, weather_code, temperature_2m_max, temperature_2m_min, apparent_temperature_max, apparent_temperature_min;
    String sunrise, sunset, precipitation_sum, rain_sum, wind_speed_10m_max, wind_gusts_10m_max;

    DailyUnits({
        required this.weather_code, required this.time, required this.apparent_temperature_max, required this.sunrise,
        required this.apparent_temperature_min, required this.precipitation_sum, required this.temperature_2m_max,
        required this.rain_sum, required this.sunset, required this.temperature_2m_min, required this.wind_gusts_10m_max,
        required this.wind_speed_10m_max
    });

    factory DailyUnits.fromJson(dynamic json) {
        return DailyUnits(
            apparent_temperature_min: JsonParser.parseString(json, "apparent_temperature_min"), apparent_temperature_max: JsonParser.parseString(json, "apparent_temperature_max"),
            sunrise: JsonParser.parseString(json, "sunrise"), sunset: JsonParser.parseString(json, "sunset"), weather_code: JsonParser.parseString(json, "weather_code"),
            temperature_2m_min: JsonParser.parseString(json, "temperature_2m_min"), temperature_2m_max: JsonParser.parseString(json, "temperature_2m_max"),
            time: JsonParser.parseString(json, "time"), precipitation_sum: JsonParser.parseString(json, "precipitation_sum"), rain_sum: JsonParser.parseString(json, "rain_sum"),
            wind_gusts_10m_max: JsonParser.parseString(json, "wind_gusts_10m_max"), wind_speed_10m_max: JsonParser.parseString(json, "wind_speed_10m_max")
        );
    }

    Map toJson() => {
        "time": time, "weather_code": weather_code, "apparent_temperature_min": apparent_temperature_min, "apparent_temperature_max": apparent_temperature_max,
        "sunset": sunset, "sunrise": sunrise, "temperature_2m_min": temperature_2m_min, "temperature_2m_max": temperature_2m_max,
        "precipitation_sum": precipitation_sum, "rain_sum": rain_sum, "wind_gusts_10m_max": wind_gusts_10m_max, "wind_speed_10m_max": wind_speed_10m_max
    };

    String serialize() => jsonEncode(toJson());
}

class Daily{
    List<DateTime>time, sunrise, sunset;
    List<int> weather_code;
    List<double> temperature_2m_max, temperature_2m_min, apparent_temperature_max, apparent_temperature_min;
    List<double> precipitation_sum, rain_sum, wind_speed_10m_max, wind_gusts_10m_max;

    Daily({
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

    Map toJson() => {
        "time": time, "weather_code": weather_code, "apparent_temperature_min": apparent_temperature_min, "apparent_temperature_max": apparent_temperature_max,
        "sunset": sunset, "sunrise": sunrise, "temperature_2m_min": temperature_2m_min, "temperature_2m_max": temperature_2m_max,
        "precipitation_sum": precipitation_sum, "rain_sum": rain_sum, "wind_gusts_10m_max": wind_gusts_10m_max, "wind_speed_10m_max": wind_speed_10m_max
    };

    String serialize() => jsonEncode(toJson());
}

class Result{
    double latitude, longitude, generationtime_ms, elevation;
    int utc_offset_seconds;
    String timezone, timezone_abbreviation;

    CurrentUnits current_units;
    Current current;

    HourlyUnits hourly_units;
    Hourly hourly;

    DailyUnits daily_units;
    Daily daily;

    Result({
        required this.latitude, required this.longitude, required this.generationtime_ms, required this.elevation,
        required this.timezone, required this.timezone_abbreviation, required this.utc_offset_seconds,
        required this.current_units, required this.current,
        required this.hourly_units, required this.hourly,
        required this.daily_units, required this.daily,
    });

    factory Result.fromJson(dynamic json) {
        return Result(
            latitude: JsonParser.parseDouble(json, "latitude"), longitude: JsonParser.parseDouble(json, "longitude"), generationtime_ms: JsonParser.parseDouble(json, "generationtime_ms"),
            elevation: JsonParser.parseDouble(json, "elevation"), timezone: JsonParser.parseString(json, "timezone"), timezone_abbreviation: JsonParser.parseString(json, "timezone_abbreviation"),
            utc_offset_seconds: JsonParser.parseInt(json, "utc_offset_seconds"),
            current_units: CurrentUnits.fromJson(json["current_units"]), current: Current.fromJson(json["current"]),
            hourly_units: HourlyUnits.fromJson(json["hourly_units"]), hourly: Hourly.fromJson(json["hourly"]),
            daily_units: DailyUnits.fromJson(json["daily_units"]), daily: Daily.fromJson(json["daily"])
        );
    }

    Map<String, dynamic> toJson() => {
        "latitude": latitude, "longitude": longitude, "generationtime_ms": generationtime_ms, "elevation": elevation,
        "timezone": timezone, "timezone_abbreviation": timezone_abbreviation, "utc_offset_seconds": utc_offset_seconds,
        "current_units": current_units.toJson(), "current": current.toJson(), "hourly_units": hourly_units.toJson(), "hourly": hourly.toJson(),
        "daily_units": daily_units.toJson(), "daily": daily.toJson()
    };

    String serialize() => jsonEncode(toJson());
}