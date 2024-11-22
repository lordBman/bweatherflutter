import 'dart:convert';

import 'package:bweather_open_meteo_api/bweather_open_meteo_api.dart';

import 'package:equatable/equatable.dart';

class Forecast extends Equatable{
    final City city;
    final Result result;

    const Forecast({ required this.city, required this.result, });

    factory Forecast.fromJson(dynamic json) {
        return Forecast( city: json["city"], result: json["result"]);
    }

    Map<String, dynamic> toJson() => { "city": city.toJson(), "result": result.toJson() };

    String serialize() => jsonEncode(toJson());
    
    @override
    List<Object?> get props => [city, result];
}