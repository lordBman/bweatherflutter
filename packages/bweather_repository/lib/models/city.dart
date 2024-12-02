import 'dart:convert';

import 'package:bweather_open_meteo_api/util.dart';
import 'package:bweather_repository/models/forecast.dart';
import 'package:equatable/equatable.dart';

class City extends Equatable{
    final String name, country;
    final String timezone;
    final double elevation, latitude, longitude;

    final Forecast? forecast; 

    const City({ required this.name, required this.elevation, this.timezone = "auto", required this.country, required this.latitude, required this.longitude, this.forecast });

    factory City.fromJson(dynamic json) {
        final init = json["forecast"] != null ? Forecast.fromJson(json["forecast"]) : null;
        return City(forecast: init, name: json["name"].toString(), timezone: json["timezone"].toString(), country: json["country"].toString(), latitude: JsonParser.parseDouble(json, "latitude"), longitude: JsonParser.parseDouble(json, "longitude"), elevation: JsonParser.parseDouble(json, "elevation"));
    }

    Map<String, dynamic> toJson() => { "name" : name, "timezone": timezone, "elevation": elevation, "country" : country, "latitude": latitude, "longitude": longitude, "forecast": forecast?.toJson() };

    String serialize() => jsonEncode(toJson());
    
    @override
    List<Object?> get props => [name, elevation, timezone, country, latitude, longitude, forecast];
}