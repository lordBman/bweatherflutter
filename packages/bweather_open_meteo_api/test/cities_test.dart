import 'dart:convert';

import 'package:bweather_open_meteo_api/cities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    group('City', () {
        group('Constructor', () {
            test('returns an instance City object', () {
                expect(const City(name: 'Chicago', elevation: 2.4, country: "America", latitude: 41.85003, longitude: -87.65005),
                    isA<City>().having((w) => w.name, 'name', 'Chicago')
                        .having((w) => w.country, 'country', 'America')
                        .having((w) => w.elevation, 'elevation', 2.4)
                        .having((w) => w.latitude, 'latitude', 41.85003)
                        .having((w) => w.longitude, 'longitude', -87.65005));
            });
        });
        group('fromJson', () {
            test('returns correct City object', () {
                expect(City.fromJson(<String, dynamic>{ 'name': 'Chicago', "elevation": 2.4, "country": "America", 'latitude': 41.85003, 'longitude': -87.65005 }),
                    isA<City>()
                        .having((w) => w.name, 'name', 'Chicago')
                        .having((w) => w.country, 'country', 'America')
                        .having((w) => w.elevation, 'elevation', 2.4)
                        .having((w) => w.latitude, 'latitude', 41.85003)
                        .having((w) => w.longitude, 'longitude', -87.65005));
            });
            test('returns correct City object', () {
                expect(City.fromJson(jsonDecode('{ "name": "Chicago", "elevation": 2.4, "country": "America", "latitude": 41.85003, "longitude": -87.65005 }')),
                    isA<City>()
                        .having((w) => w.name, 'name', 'Chicago')
                        .having((w) => w.country, 'country', 'America')
                        .having((w) => w.elevation, 'elevation', 2.4)
                        .having((w) => w.latitude, 'latitude', 41.85003)
                        .having((w) => w.longitude, 'longitude', -87.65005));
            });
        });
        group('toJson', () {
            test('returns a map json of City object', () {
                expect(const City(name: 'Chicago', elevation: 2.4, country: "America", latitude: 41.85003, longitude: -87.65005).toJson(),
                    isA<Map<String, dynamic>>()
                        .having((c) => c["name"], "name", "Chicago")
                        .having((c) => c["country"], "country", "America")
                        .having((c) => c["elevation"], "elevation", 2.4)
                        .having((c) => c["latitude"], "latitude", 41.85003)
                        .having((c) => c["longitude"], "longitude", -87.65005));
            });
            test('returns a serialized json of City object', () {
                expect(const City(name: 'Chicago', elevation: 2.4, country: "America", latitude: 41.85003, longitude: -87.65005).serialize(),
                    isA<String>()
                        .having((c) => c, "Serialized", '{"name":"Chicago","timezone":"auto","elevation":2.4,"country":"America","latitude":41.85003,"longitude":-87.65005}'));
            });
        });
    });
}