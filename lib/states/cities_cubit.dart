import 'dart:developer';

import 'package:bweather_repository/bweather_repository.dart';
import 'package:bweatherflutter/utils/cities.dart';
import 'package:bweatherflutter/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

enum SortBy{ name, country }

class CitiesState{
    final Map<int, String> letters;
    final SortBy sortBy;
    final List<City> searchResults;
    final StateStatus status;
    final String message;

    const CitiesState({ this.message = "", this.letters = const {}, this.sortBy = SortBy.name, this.searchResults = const [], this.status = StateStatus.initial });

    CitiesState copy({ String? message, Map<int, String>? letters, SortBy? sortBy, List<City>? searchResults, StateStatus? status }){
        return CitiesState(
            status: status ?? this.status,
            message: message ?? this.message,
            letters: letters ?? this.letters,
            searchResults: searchResults ?? this.searchResults,
            sortBy: sortBy ?? this.sortBy);
    }
}

class CitiesCubit extends Cubit<CitiesState>{
    final ForecastRepository __repository = ForecastRepository(units: Units());

    set sortBy(SortBy sortBy){
        emit(state.copy(sortBy: sortBy));
        sort();
    }

    CitiesCubit(): super(const CitiesState()){
        sort();
    }

    Future<void> search(String query) async{
        try{
            emit(state.copy(status: StateStatus.loading));

            final init = await __repository.search(query);
            emit(state.copy(searchResults: init, status: StateStatus.success));
        }catch(error){
            log("City search error:", error: error);
            emit(state.copy(message: "Something went wrong, please check internet connection", status: StateStatus.failure));
        }
    }

    Future<void> sort() async {
        List<MapEntry<int, String>> entries = [];

        cities.sort((CityData a, CityData b)=> state.sortBy == SortBy.name ? a.name.compareTo(b.name) : a.country.compareTo(b.country));
        
        String last = "";
        for (int index = 0; index < cities.length; index++) {
            CityData city = cities[index];
            String letter = (state.sortBy == SortBy.name ? city.name : city.country).characters.first.toUpperCase();
            if(last != letter){
                entries.add(MapEntry(index, letter));
                last = letter;
            }
        }
        emit(state.copy(letters: Map<int, String>.fromEntries(entries)));
    }
}