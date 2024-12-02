import 'dart:convert';
import 'dart:developer';

import 'package:bweather_open_meteo_api/cities.dart';
import 'package:bweather_open_meteo_api/model.dart';
import 'package:http/http.dart';

/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.z
class WeatherNotFoundFailure implements Exception {}

/// {@template open_meteo_api_client}
/// Dart API Client which wraps the [Open Meteo API](https://open-meteo.com).
/// {@endtemplate}
class WeatherClient{
    static const _baseUrlWeather = 'api.open-meteo.com';
    static const _baseUrlGeocoding = 'geocoding-api.open-meteo.com';

    final Client _httpClient;

    /// {@macro open_meteo_api_client}
    WeatherClient({ Client? httpClient}): _httpClient = httpClient ?? Client();

    /// Fetches [Weather] for a given [latitude] and [longitude].
    Future<Result> forecast(City city, { required String precipitationUnit, required String tempUnit, required String windSpeedUnit }) async{
        try{
            Map<String, String> params = {
                "latitude" : city.latitude.toString(),
                "longitude": city.longitude.toString(),
                "elevation": city.elevation.toString(),
                "temperature_unit": tempUnit,
                "wind_speed_unit": windSpeedUnit,
                "precipitation_unit": precipitationUnit,
                "current": "temperature_2m,relative_humidity_2m,apparent_temperature,is_day,rain,weather_code,pressure_msl,surface_pressure,wind_speed_10m,wind_direction_10m,wind_gusts_10m,precipitation,cloud_cover",
                "hourly": "temperature_2m,relative_humidity_2m,dew_point_2m,apparent_temperature,precipitation_probability,rain,weather_code",
                "daily": "weather_code,temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,sunrise,sunset,precipitation_sum,rain_sum,wind_speed_10m_max,wind_gusts_10m_max",
                "timezone": city.timezone
            };

            final weatherRequest = Uri.https(_baseUrlWeather, 'v1/forecast', params);

            final weatherResponse = await _httpClient.get(weatherRequest);

            if (weatherResponse.statusCode != 200) {
                throw WeatherRequestFailure();
            }

            return Result.fromJson(jsonDecode(weatherResponse.body) as Map<String, dynamic>);
        }catch(error){
            log("Weather error - ${city.name}", error: error);
            //throw Exception("Weather error - ${city.name} - $error");
            if(error is WeatherRequestFailure){
                rethrow;
            }
            throw WeatherNotFoundFailure();
        }
    }

    /// Finds a [City] `/v1/search/?name=(query)`.
    Future<List<City>> locationSearch(String query) async {
        final locationRequest = Uri.https( _baseUrlGeocoding, '/v1/search', {'name': query });

        final locationResponse = await _httpClient.get(locationRequest);

        if (locationResponse.statusCode != 200) {
            throw LocationRequestFailure();
        }

        final locationJson = jsonDecode(locationResponse.body) as Map<String, dynamic>;

        if (!locationJson.containsKey('results') || (locationJson['results'] as List).isEmpty){
            throw LocationNotFoundFailure();
        }

        return (locationJson['results'] as List).map((element) => City.fromJson(element)).toList();
    }
}