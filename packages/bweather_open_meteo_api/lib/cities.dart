import 'dart:convert';

import 'package:bweather_open_meteo_api/util.dart';

class City{
    final String name, country;
    final String timezone;
    final double? elevation;
    final double latitude, longitude;

    const City({ required this.name, this.elevation, this.timezone = "auto", required this.country, required this.latitude, required this.longitude });

    factory City.fromJson(dynamic json) {
        return City(name: (json["name"] ?? json["city"]).toString(), timezone: json["timezone"].toString(), country: json["country"].toString(), latitude: JsonParser.parseDouble(json, "latitude"), longitude: JsonParser.parseDouble(json, "longitude"), elevation: json['elevation'] != null ? JsonParser.parseDouble(json, "elevation") : null);
    }

    Map<String, dynamic> toJson() => { "name" : name, "timezone": timezone, "elevation": elevation, "country" : country, "latitude": latitude, "longitude": longitude };

    String serialize() => jsonEncode(toJson());

    @override
    bool operator == (covariant Object other){
        if(other is City){
            return name == other.name;
        }
        return false;
    }
}