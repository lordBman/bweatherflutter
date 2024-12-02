import 'dart:convert';

import 'package:bweatherflutter/states/forecast/city_state.dart';
import 'package:bweatherflutter/utils/status.dart';
import 'package:equatable/equatable.dart';

class WeatherState extends Equatable{
    final List<CityState> cities;
    final String message;
    final dynamic error;

    final StateStatus status;
    
    const WeatherState({ this.cities = const [], this.status = StateStatus.initial, this.message = "", this.error });

    factory WeatherState.fromJson(dynamic json) {
        return WeatherState( cities: (json["city"] as List).map((element)=> CityState.fromJson(element)).toList(), status: json["status"].toString().toForecaseStatus);
    }

    WeatherState copy( { List<CityState>? cities, StateStatus? status, String? message, dynamic error } ){
        return WeatherState(
            cities: cities ?? this.cities,
            status: status ?? this.status,
            message: message ?? this.message,
            error: error
        );
    }

    Map<String, dynamic> toJson() => { "city": cities.map((element)=> element.toJson()).toList(), "status": status.serialize };

    String serialize() => jsonEncode(toJson());
    
    @override
    List<Object?> get props => [ cities, status];
}