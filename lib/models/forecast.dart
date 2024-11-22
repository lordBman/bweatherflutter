import "dart:convert";

import "package:bweather_repository/bweather_repository.dart" as repository;
import "package:equatable/equatable.dart";

class Forecast extends Equatable{
    repository.City city;
    repository.Result? result;
    DateTime lastUpdated;
    
    Forecast({ required this.city, required this.result, required this.lastUpdated });

    factory Forecast.fromJson(dynamic json) {
        return Forecast( city: json["city"], result: json["result"], lastUpdated: json["lastUpdated"]);
    }

    factory Forecast.fromRepository(repository.Forecast forecast){
        return Forecast(city: forecast.city, result: forecast.result, lastUpdated: DateTime.now());
    }

    Map<String, dynamic> toJson() => { "city": city.toJson(), "result": result?.toJson() };

    String serialize() => jsonEncode(toJson());
    
    @override
    List<Object?> get props => [city, result, lastUpdated];
}