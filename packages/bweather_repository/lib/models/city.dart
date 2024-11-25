import 'dart:convert';

import 'package:bweather_open_meteo_api/util.dart';
import 'package:bweather_repository/models/forecast.dart';
import 'package:equatable/equatable.dart';

class City extends Equatable{
    final String name, country;
    final String timezone;
    final double elavation, latitude, longitude;

    final Forecast? forecast; 

    const City({ required this.name, required this.elavation, this.timezone = "auto", required this.country, required this.latitude, required this.longitude, this.forecast });

    factory City.fromJson(dynamic json) {
        return City(name: json["name"].toString(), timezone: json["timezone"].toString(), country: json["country"].toString(), latitude: JsonParser.parseDouble(json, "latitude"), longitude: JsonParser.parseDouble(json, "longitude"), elavation: JsonParser.parseDouble(json, "elavation"));
    }

    Map toJson() => { "name" : name, "timezone": timezone, "elavation": elavation, "country" : country, "latitude": latitude, "longitude": longitude, "forecast": forecast?.toJson() };

    String serialize() => jsonEncode(toJson());

    @override
    bool operator == (covariant Object other){
        if(other is City){
            return name == other.name;
        }
        return false;
    }
    
    @override
    List<Object?> get props => [name, country, forecast];
}