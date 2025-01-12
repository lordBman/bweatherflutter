import "dart:convert";

import "package:bweather_repository/bweather_repository.dart";
import "package:bweatherflutter/utils/status.dart";
import "package:equatable/equatable.dart";

class CityState extends Equatable{
    final City city;
    final String message;
    final dynamic error;

    final StateStatus status;
    
    const CityState({ required this.city, this.status = StateStatus.initial, this.message = "", this.error });

    factory CityState.fromJson(dynamic json) {
        return CityState( city: City.fromJson(json["city"]), status: json["status"].toString().toForecaseStatus);
    }

    CityState copy( { City? city, StateStatus? status, String? message, dynamic error } ){
        return CityState(
            city: city ?? this.city,
            status: status ?? this.status,
            message: message ?? this.message,
            error: error
        );
    }

    Map<String, dynamic> toJson() => { "city": city.toJson(), "status": status.serialize };

    String serialize() => jsonEncode(toJson());
    
    @override
    List<Object?> get props => [ city, status];
}