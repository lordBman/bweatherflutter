import 'dart:convert';

import 'package:equatable/equatable.dart';

enum TempUnit{ fahrenheit, celsius }
extension TempUnitExtension on TempUnit{
    String get serialize{
        switch(this){
            case TempUnit.fahrenheit:
                return "fahrenheit";
            case TempUnit.celsius:
                return "celsius";
        }
    }
}
extension TempUnitFromStringExtension on String{
    TempUnit get tempUnit{
        switch(this){
            case "fahrenheit":
                return TempUnit.fahrenheit;
            case "celsius":
                return TempUnit.celsius;
            default:
                throw Exception("$this is not a Temperature Unit");
        }
    }
}

enum WindSpeedUnit { ms, mph, kmh, kn }
extension WindSpeedUnitExtension on WindSpeedUnit{
    String get serialize{
        switch(this){
            case WindSpeedUnit.ms:
                return "ms";
            case WindSpeedUnit.mph:
                return "mph";
            case WindSpeedUnit.kmh:
                return "kmh";
            case WindSpeedUnit.kn:
                return "kn";
        }
    }
}
extension WindSpeedUnitFromStringExtension on String{
    WindSpeedUnit get windSpeedUnit{
        switch(this){
            case "ms":
                return WindSpeedUnit.ms;
            case "mph":
                return WindSpeedUnit.mph;
            case "kn":
                return WindSpeedUnit.kn;
            case "kmh":
                return WindSpeedUnit.kmh;
            default:
                throw Exception("$this is not a Wind Speed Unit");
        }
    }
}

enum PrecipitationUnit{ inch, mm }
extension PrecipitationUnitExtension on PrecipitationUnit{
    String get serialize{
        switch(this){
            case PrecipitationUnit.inch:
                return "inch";
            case PrecipitationUnit.mm:
                return "mm";
        }
    }
}

extension PrecipitationUnitParseExtension on String{
  PrecipitationUnit get precipitationUnit{
      switch(this){
        case "inch":
            return PrecipitationUnit.inch;
        case "mm":
            return PrecipitationUnit.mm;
        default:
            throw Exception("$this is not a Precipitation Unit");
    }
  }
}

class Units extends Equatable{
    final TempUnit temp_unit;
    final WindSpeedUnit wind_speed_unit;
    final PrecipitationUnit precipitation_unit;

    const Units({
        this.temp_unit = TempUnit.celsius, this.wind_speed_unit = WindSpeedUnit.ms,
        this.precipitation_unit = PrecipitationUnit.mm,
    });

    const Units.defaults() : temp_unit = TempUnit.celsius, wind_speed_unit = WindSpeedUnit.ms, precipitation_unit = PrecipitationUnit.mm;

    factory Units.fromJson(dynamic json) {
        return Units(
            temp_unit: json["temp_unit"].toString().tempUnit,
            wind_speed_unit: json["wind_speed_unit"].toString().windSpeedUnit,
            precipitation_unit: json["precipitation_unit"].toString().precipitationUnit);
    }

    Units copy({ TempUnit? temp_unit, WindSpeedUnit? wind_speed_unit, PrecipitationUnit? precipitation_unit }){
        return Units(
            temp_unit: temp_unit ?? this.temp_unit,
            precipitation_unit: precipitation_unit ?? this.precipitation_unit,
            wind_speed_unit: wind_speed_unit ?? this.wind_speed_unit
        );
    }

    Map<String, dynamic> toJson() => {
        "temp_unit" : temp_unit.serialize, "wind_speed_unit": wind_speed_unit.serialize,
        "precipitation_unit": precipitation_unit.serialize,
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [ temp_unit.serialize, precipitation_unit.serialize, wind_speed_unit.serialize ];
}