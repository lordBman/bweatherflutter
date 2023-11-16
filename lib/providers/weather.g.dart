// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      json['id'] as int,
      json['main'] as String,
      json['description'] as String,
      json['icon'] as String,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

Current _$CurrentFromJson(Map<String, dynamic> json) => Current(
      json['dt'] as int,
      json['sunrise'] as int,
      json['sunset'] as int,
      json['clouds'] as int,
      (json['dew_point'] as num).toDouble(),
      (json['feels_like'] as num).toDouble(),
      json['humidity'] as int,
      json['pressure'] as int,
      (json['temp'] as num).toDouble(),
      (json['uvi'] as num).toDouble(),
      json['visibility'] as int,
      (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['wind_deg'] as int,
      (json['wind_gust'] as num).toDouble(),
      (json['wind_speed'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrentToJson(Current instance) => <String, dynamic>{
      'dt': instance.dt,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'temp': instance.temp,
      'feels_like': instance.feels_like,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'dew_point': instance.dew_point,
      'uvi': instance.uvi,
      'clouds': instance.clouds,
      'visibility': instance.visibility,
      'wind_speed': instance.wind_speed,
      'wind_deg': instance.wind_deg,
      'wind_gust': instance.wind_gust,
      'weather': instance.weather,
    };

Hourly _$HourlyFromJson(Map<String, dynamic> json) => Hourly(
      json['dt'] as int,
      json['clouds'] as int,
      (json['dew_point'] as num).toDouble(),
      (json['feels_like'] as num).toDouble(),
      json['humidity'] as int,
      (json['pop'] as num).toDouble(),
      json['pressure'] as int,
      (json['temp'] as num).toDouble(),
      (json['uvi'] as num).toDouble(),
      json['visibility'] as int,
      (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['wind_deg'] as int,
      (json['wind_gust'] as num).toDouble(),
      (json['wind_speed'] as num).toDouble(),
    );

Map<String, dynamic> _$HourlyToJson(Hourly instance) => <String, dynamic>{
      'dt': instance.dt,
      'temp': instance.temp,
      'feels_like': instance.feels_like,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'dew_point': instance.dew_point,
      'uvi': instance.uvi,
      'clouds': instance.clouds,
      'visibility': instance.visibility,
      'wind_speed': instance.wind_speed,
      'wind_deg': instance.wind_deg,
      'wind_gust': instance.wind_gust,
      'weather': instance.weather,
      'pop': instance.pop,
    };

Temp _$TempFromJson(Map<String, dynamic> json) => Temp(
      (json['day'] as num).toDouble(),
      (json['eve'] as num).toDouble(),
      (json['max'] as num).toDouble(),
      (json['min'] as num).toDouble(),
      (json['morn'] as num).toDouble(),
      (json['night'] as num).toDouble(),
    );

Map<String, dynamic> _$TempToJson(Temp instance) => <String, dynamic>{
      'day': instance.day,
      'min': instance.min,
      'max': instance.max,
      'night': instance.night,
      'eve': instance.eve,
      'morn': instance.morn,
    };

FeelsLike _$FeelsLikeFromJson(Map<String, dynamic> json) => FeelsLike(
      (json['day'] as num).toDouble(),
      (json['eve'] as num).toDouble(),
      (json['morn'] as num).toDouble(),
      (json['night'] as num).toDouble(),
    );

Map<String, dynamic> _$FeelsLikeToJson(FeelsLike instance) => <String, dynamic>{
      'day': instance.day,
      'night': instance.night,
      'eve': instance.eve,
      'morn': instance.morn,
    };

Daily _$DailyFromJson(Map<String, dynamic> json) => Daily(
      json['clouds'] as int,
      (json['dew_point'] as num).toDouble(),
      json['dt'] as int,
      FeelsLike.fromJson(json['feels_like'] as Map<String, dynamic>),
      json['humidity'] as int,
      (json['moon_phase'] as num).toDouble(),
      json['moonrise'] as int,
      json['moonset'] as int,
      (json['pop'] as num).toDouble(),
      json['pressure'] as int,
      (json['rain'] as num).toDouble(),
      json['summary'] as String,
      (json['uvi'] as num).toDouble(),
      json['sunrise'] as int,
      json['sunset'] as int,
      Temp.fromJson(json['temp'] as Map<String, dynamic>),
      (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['wind_deg'] as int,
      (json['wind_gust'] as num).toDouble(),
      (json['wind_speed'] as num).toDouble(),
    );

Map<String, dynamic> _$DailyToJson(Daily instance) => <String, dynamic>{
      'dt': instance.dt,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'moonrise': instance.moonrise,
      'moonset': instance.moonset,
      'moon_phase': instance.moon_phase,
      'summary': instance.summary,
      'temp': instance.temp,
      'feels_like': instance.feels_like,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'dew_point': instance.dew_point,
      'wind_speed': instance.wind_speed,
      'wind_deg': instance.wind_deg,
      'wind_gust': instance.wind_gust,
      'weather': instance.weather,
      'clouds': instance.clouds,
      'pop': instance.pop,
      'rain': instance.rain,
      'uvi': instance.uvi,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      Current.fromJson(json['current'] as Map<String, dynamic>),
      (json['daily'] as List<dynamic>)
          .map((e) => Daily.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['hourly'] as List<dynamic>)
          .map((e) => Hourly.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['lat'] as num).toDouble(),
      (json['lon'] as num).toDouble(),
      json['timezone'] as String,
      json['timezone_offset'] as int,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'timezone': instance.timezone,
      'timezone_offset': instance.timezone_offset,
      'current': instance.current,
      'hourly': instance.hourly,
      'daily': instance.daily,
    };
