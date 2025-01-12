import 'dart:developer';

import 'package:bweather_repository/bweather_repository.dart';
import 'package:http/http.dart';

import 'package:bweather_open_meteo_api/bweather_open_meteo_api.dart' as api;
import 'package:bweather_repository/models/city.dart' as city_model;
import 'package:bweather_repository/models/forecast.dart' as models;
import 'package:bweather_repository/units.dart';

class ForecastRepository {
    final api.WeatherClient __client;

    ForecastRepository({ Client? httpClient }): __client = api.WeatherClient(httpClient: httpClient ?? Client());

    Future<city_model.City> getWeather(city_model.City city, { Units units = const Units.defaults() }) async {
        api.City requestCity = api.City(name: city.name, elevation: city.elevation, country: city.country, latitude: city.latitude, longitude: city.longitude);
        final result = await __client.forecast(requestCity, precipitationUnit: units.precipitation_unit.serialize, tempUnit: units.temp_unit.serialize, windSpeedUnit: units.wind_speed_unit.serialize);

        models.Current current = models.Current(
            apparent_temperature: models.Value(value: result.current.apparent_temperature, unit: result.current_units.apparent_temperature),
            wind_direction: models.Value(value: result.current.wind_direction_10m, unit: result.current_units.wind_direction_10m),
            wind_gusts: models.Value(value: result.current.wind_gusts_10m, unit: result.current_units.wind_gusts_10m),
            weather_code: result.current.weather_code, time: result.current.time,
            wind_speed: models.Value(value: result.current.wind_speed_10m, unit: result.current_units.wind_speed_10m),
            temperature: models.Value(value: result.current.temperature_2m, unit: result.current_units.temperature_2m),
            surface_pressure: models.Value(value: result.current.surface_pressure, unit: result.current_units.surface_pressure),
            relative_humidity: models.Value(value: result.current.relative_humidity_2m, unit: result.current_units.relative_humidity_2m),
            rain: models.Value(value: result.current.rain, unit: result.current_units.rain),
            precipitation: models.Value(value: result.current.precipitation, unit: result.current_units.precipitation),
            cloud_cover: models.Value(value: result.current.cloud_cover, unit: result.current_units.cloud_cover),
            is_day: result.current.is_day == 1
        );

        List<models.Daily> daily = [];
        for(int i = 0; i < result.daily.temperature_2m_min.length; i++){
            daily.add(models.Daily(
                apparent_temperature_max: models.Value(value: result.daily.apparent_temperature_max[i], unit: result.daily_units.apparent_temperature_max),
                apparent_temperature_min: models.Value(value: result.daily.apparent_temperature_min[i], unit: result.daily_units.apparent_temperature_min),
                temperature_max: models.Value(value: result.daily.temperature_2m_max[i], unit: result.daily_units.temperature_2m_max),
                temperature_min: models.Value(value: result.daily.temperature_2m_min[i], unit: result.daily_units.temperature_2m_min),
                time: result.daily.time[i], weather_code: result.daily.weather_code[i]
            ));
        }

        List<models.Hourly> hourly = [];
        for(int i = 0; i < result.hourly.temperature_2m.length; i++){
            hourly.add(models.Hourly(
                time: result.hourly.time[i], weather_code: result.hourly.weather_code[i],
                dew_point: models.Value(value: result.hourly.dew_point_2m[i], unit: result.hourly_units.dew_point_2m),
                precipitation_probability: models.Value(value: result.hourly.precipitation_probability[i], unit: result.hourly_units.precipitation_probability),
                temperature: models.Value(value: result.hourly.temperature_2m[i], unit: result.hourly_units.temperature_2m),
                relative_humidity: models.Value(value: result.hourly.relative_humidity_2m[i], unit: result.hourly_units.relative_humidity_2m),
                apparent_temperature: models.Value(value: result.hourly.apparent_temperature[i], unit: result.hourly_units.apparent_temperature),
                rain: models.Value(value: result.hourly.rain[i], unit: result.hourly_units.rain)
            ));
        }

        models.Forecast forecast = models.Forecast(
            utc_offset_seconds: result.utc_offset_seconds,
            current: current, daily: daily, hourly: hourly
        );
        
        return city_model.City(name: city.name, timezone: result.timezone, elevation: result.elevation, country: city.country, latitude: result.latitude, longitude: result.longitude, forecast: forecast);
    }

    Future<List<city_model.City>> search(String query) async{
        final locations = await __client.locationSearch(query);

        log("Looking for city $query and found $locations");

        return locations.map((location)=> city_model.City(
            name: location.name, country: location.country, elevation: location.elevation,
            timezone: location.timezone, latitude: location.latitude, longitude: location.longitude
        )).toList();
    }
}