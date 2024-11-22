import 'dart:convert';
import 'dart:developer';

import 'package:bweather_open_meteo_api/cities.dart';
import 'package:bweather_open_meteo_api/model.dart';
import 'package:uno/uno.dart';

/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

final Uno __weatherAPI = Uno(
    baseURL: "https://api.open-meteo.com/v1/forecast",
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
    }
);

final Uno __locationAPI = Uno(
    baseURL: "https://geocoding-api.open-meteo.com/v1/search",
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
    }
);
class WeatherClient{
    /// Fetches [Weather] for a given [latitude] and [longitude].
    static Future<Result> forecast(City city, { required String precipitationUnit, required String tempUnit, required String windSpeedUnit }) async{
        try{
            Map<String, String> params = {
                "latitude" : city.latitude.toString(),
                "longitude": city.longitude.toString(),
                "elavation": city.elavation.toString(),
                "temperature_unit": tempUnit,
                "wind_speed_unit": windSpeedUnit,
                "precipitation_unit": precipitationUnit,
                "current": "temperature_2m,relative_humidity_2m,apparent_temperature,is_day,rain,weather_code,pressure_msl,surface_pressure,wind_speed_10m,wind_direction_10m,wind_gusts_10m,precipitation,cloud_cover",
                "hourly": "temperature_2m,relative_humidity_2m,dew_point_2m,apparent_temperature,precipitation_probability,rain,weather_code",
                "daily": "weather_code,temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,sunrise,sunset,precipitation_sum,rain_sum,wind_speed_10m_max,wind_gusts_10m_max",
                "timezone": city.timezone
            };

            return Result.fromJson((await __weatherAPI.get("/", params: params)).data);
        }catch(error){
            if(error is UnoError){
                log("Weather error - ${city.name}:${error.request!.uri.toString()}", error: error);
                throw Exception("Weather error - ${city.name}:${error.request!.uri.toString()} - $error");
            }else{
                log("Weather error - ${city.name}", error: error);
                throw Exception("Weather error - ${city.name} - $error");
            }
        }
    }

    /// Finds a [City] `/v1/search/?name=(query)`.
    static Future<List<City>> locationSearch(String query) async {
        try{
            final locationJson = jsonDecode((await __locationAPI.get("/", params: {'name': query, 'count': '1'})).data) as Map;

            if (!locationJson.containsKey('results') && (locationJson['results'] as List).isEmpty){
                throw LocationNotFoundFailure();
            }
            return (locationJson['results'] as List).map((data)=> City.fromJson(data)).toList();
        }catch(error){
            if(error is UnoError){
                log("Weather error - query:${error.request!.uri.toString()}", error: error);
                if(error.response!.status == 404){
                    throw LocationNotFoundFailure();
                }
            }
            throw LocationRequestFailure();
        }
    }
}