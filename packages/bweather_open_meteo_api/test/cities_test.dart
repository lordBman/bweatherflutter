import 'package:bweather_open_meteo_api/cities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    group('City', () {
        group('fromJson', () {
            test('returns correct Location object', () {
                expect(City.fromJson(<String, dynamic>{ 'name': 'Chicago', "country": "America", 'latitude': 41.85003, 'longitude': -87.65005 }),
                    isA<City>()
                      .having((w) => w.name, 'name', 'Chicago')
                      .having((w) => w.country, 'country', 'America')
                      .having((w) => w.latitude, 'latitude', 41.85003)
                      .having((w) => w.longitude, 'longitude', -87.65005));
            });
        });
    });
}