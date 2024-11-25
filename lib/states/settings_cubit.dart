import 'dart:convert';

import 'package:bweather_repository/bweather_repository.dart';
import 'package:bweatherflutter/states/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SettingsState {
    final TempUnit temp_unit;
    final WindSpeedUnit wind_speed_unit;
    final PrecipitationUnit precipitation_unit;

    final String themeMode;
    ThemeMode get themeModeValue{
        switch(themeMode){
            case "light":
                return ThemeMode.light;
            case "dark":
                return ThemeMode.dark;
        }
        return ThemeMode.system;
    }

    const SettingsState({
        this.temp_unit = TempUnit.celsius, this.wind_speed_unit = WindSpeedUnit.ms,
        this.precipitation_unit = PrecipitationUnit.mm, this.themeMode = "auto"
    });

    SettingsState copy({ TempUnit? temp_unit, WindSpeedUnit? wind_speed_unit, PrecipitationUnit? precipitation_unit, String? themeMode }){
        return SettingsState(
            temp_unit: temp_unit ?? this.temp_unit,
            wind_speed_unit: wind_speed_unit ?? this.wind_speed_unit,
            precipitation_unit: precipitation_unit ?? this.precipitation_unit,
            themeMode: themeMode ?? this.themeMode
        );
    }

    factory SettingsState.fromJson(dynamic json) {
        return SettingsState(
            temp_unit: json["temp_unit"].toString().tempUnit,
            wind_speed_unit: json["wind_speed_unit"].toString().windSpeedUnit,
            precipitation_unit: json["precipitation_unit"].toString().precipitationUnit,
            themeMode: json["themeMode"].toString());
    }

    Map<String, dynamic> toJson() => {
        "temp_unit" : temp_unit.serialize, "wind_speed_unit": wind_speed_unit.serialize,
        "precipitation_unit": precipitation_unit.serialize, "themeMode" : themeMode
    };

    String serialize() => jsonEncode(toJson());
}

class SettingsCubit extends HydratedCubit<SettingsState>{
    WeatherCubit? __weatherCubit;
    set weatherCubit(WeatherCubit weatherCubit){
        __weatherCubit = weatherCubit;
    }

    String get themeMode => state.themeMode;
    set themeMode(String mode){
        if(state.themeMode != mode){
            emit(state.copy(themeMode: mode));
        }
    }

    set tempUnit(TempUnit unit){
        if(state.temp_unit != unit){
            emit(state.copy(temp_unit: unit));
            if(__weatherCubit != null){
                __weatherCubit!.reload(force: true);
            }
        }
    }

    set windSpeedUnit (WindSpeedUnit unit){
        if(state.wind_speed_unit != unit){
            emit(state.copy(wind_speed_unit: unit));
            if(__weatherCubit != null){
                __weatherCubit!.reload(force: true);
            }
        }
    }

    set precipitationUnit(PrecipitationUnit unit){
        if(state.precipitation_unit != unit){
            emit(state.copy(precipitation_unit: unit));
            if(__weatherCubit != null){
                __weatherCubit!.reload(force: true);
            }
        }
    }

    SettingsCubit(): super(const SettingsState());

    @override
    SettingsState? fromJson(Map<String, dynamic> json) {
        return SettingsState.fromJson(json);
    }

    @override
    Map<String, dynamic>? toJson(SettingsState state) {
        return state.toJson();
    }
}