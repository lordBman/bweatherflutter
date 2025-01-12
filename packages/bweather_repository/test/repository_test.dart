import 'dart:convert';

import 'package:bweather_repository/bweather_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:bweather_open_meteo_api/bweather_open_meteo_api.dart' as client;

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

const __citiesResponse = '''{
    "results": [
        {
            "id": 2338229,
            "name": "Ikorodu",
            "latitude": 6.61526,
            "longitude": 3.5069,
            "elevation": 36,
            "feature_code": "PPLA2",
            "country_code": "NG",
            "admin1_id": 2332453,
            "admin2_id": 7644922,
            "timezone": "Africa/Lagos",
            "country_id": 2328926,
            "country": "Nigeria",
            "admin1": "Lagos",
            "admin2": "Ikorodu"
        },
        {
            "id": 12094463,
            "name": "Ikorodu Egbado",
            "latitude": 6.76267,
            "longitude": 2.86479,
            "elevation": 36,
            "feature_code": "PPL",
            "country_code": "NG",
            "admin1_id": 2327546,
            "timezone": "Africa/Lagos",
            "country_id": 2328926,
            "country": "Nigeria",
            "admin1": "Ogun State"
        }
    ],
    "generationtime_ms": 1.4840364
}
''';

const __resultResponse = '''{
    "latitude": 52.52, "longitude": 13.419998, "utc_offset_seconds": 0,
    "timezone": "GMT", "timezone_abbreviation": "GMT", "elevation": 38,
    "current_units": {
        "temperature_2m": "°C",
        "relative_humidity_2m": "%",
        "apparent_temperature": "°C",
        "precipitation": "mm",
        "rain": "mm",
        "weather_code": "wmo code",
        "cloud_cover": "%",
        "pressure_msl": "hPa",
        "surface_pressure": "hPa",
        "wind_speed_10m": "km/h",
        "wind_direction_10m": "°",
        "wind_gusts_10m": "km/h"
    },
    "current": {
        "time": "2024-11-26T07:00",
        "temperature_2m": 8.9,
        "relative_humidity_2m": 93,
        "apparent_temperature": 7.4,
        "is_day": 1,
        "precipitation": 0,
        "rain": 0,
        "weather_code": 3,
        "cloud_cover": 100,
        "pressure_msl": 1015.7,
        "surface_pressure": 1011,
        "wind_speed_10m": 6.6,
        "wind_direction_10m": 248,
        "wind_gusts_10m": 14
    },
    "hourly_units": {
        "temperature_2m": "°C",
        "relative_humidity_2m": "%",
        "dew_point_2m": "°C",
        "apparent_temperature": "°C",
        "precipitation_probability": "%",
        "precipitation": "mm",
        "rain": "mm",
        "weather_code": "wmo code",
        "pressure_msl": "hPa",
        "surface_pressure": "hPa",
        "cloud_cover": "%",
        "wind_speed_10m": "km/h",
        "wind_direction_10m": "°",
        "wind_gusts_10m": "km/h",
        "temperature_80m": "°C"
    },
    "hourly": {
        "time": [ "2024-11-26T00:00", "2024-11-26T01:00"], "temperature_2m": [ 10.5, 10.6 ],
        "relative_humidity_2m": [ 77, 87 ], "dew_point_2m": [ 6.7, 8.6 ],
        "apparent_temperature": [ 8.6, 9.1 ], "precipitation_probability": [ 90, 100 ],
        "precipitation": [ 0.3, 0.1 ], "rain": [ 0.1, 0.1 ],
        "weather_code": [ 61, 61 ], "pressure_msl": [ 1011, 1011 ],
        "surface_pressure": [ 1006.4, 1006.4 ], "cloud_cover": [ 100, 100 ],
        "wind_speed_10m": [ 7.6, 8.3 ], "wind_direction_10m": [ 225, 275],
        "wind_gusts_10m": [ 17.6, 17.6 ], "temperature_80m": [ 10.5, 10.6 ]
    },
    "daily_units": {
        "time": "iso8601",
        "weather_code": "wmo code",
        "temperature_2m_max": "°C",
        "temperature_2m_min": "°C",
        "apparent_temperature_max": "°C",
        "apparent_temperature_min": "°C",
        "sunrise": "iso8601",
        "sunset": "iso8601",
        "precipitation_sum": "mm",
        "rain_sum": "mm",
        "precipitation_probability_max": "%",
        "wind_speed_10m_max": "km/h",
        "wind_gusts_10m_max": "km/h",
        "wind_direction_10m_dominant": "°"
    },
    "daily": {
        "time": [ "2024-11-26", "2024-11-27" ], "weather_code": [ 80, 80 ],
        "temperature_2m_max": [ 10.6, 7.7 ], "temperature_2m_min": [ 6.9, 4.5 ],
        "apparent_temperature_max": [ 9.1, 5.5], "apparent_temperature_min": [ 4.8, 2.2],
        "sunrise": [ "2024-11-26T06:47", "2024-11-27T06:49" ], "sunset": [ "2024-11-26T14:59", "2024-11-27T14:58"],
        "precipitation_sum": [ 2.6, 6.3 ], "rain_sum": [ 2.3, 6.2 ],
        "precipitation_probability_max": [ 100, 90], "wind_speed_10m_max": [ 13.4, 17.6],
        "wind_gusts_10m_max": [ 29.2, 37.4 ], "wind_direction_10m_dominant": [ 242, 182 ]
    }
}''';

void main() {
    group('Repository', () {
        late http.Client httpClient;
        late ForecastRepository repository;

        setUpAll(() { registerFallbackValue(FakeUri()); });

        setUp(() {
            httpClient = MockHttpClient();
            repository = ForecastRepository(httpClient: httpClient);
        });

        group('constructor', () {
            test('does not require an Forecast Repository', () {
                expect(ForecastRepository(), isNotNull);
            });
        });

        group('locationSearch', () {
            const query = 'mock-query';

            test('makes correct http request', () async {
                final response = MockResponse();
                when(() => response.statusCode).thenReturn(200);
                when(() => response.body).thenReturn('{}');
                when(() => httpClient.get(any())).thenAnswer((_) async => response);
                try {
                    await repository.search(query);
                } catch (_) {}
                verify(() => httpClient.get(Uri.https('geocoding-api.open-meteo.com', '/v1/search', {'name': query }))).called(1);
            });

            test('throws LocationRequestFailure on non-200 response', () async {
                final response = MockResponse();
                when(() => response.statusCode).thenReturn(400);
                when(() => httpClient.get(any())).thenAnswer((_) async => response);

                expect(() async => repository.search(query), throwsA(isA<client.LocationRequestFailure>()));
            });

            test('throws LocationNotFoundFailure on error response', () async {
                final response = MockResponse();
                when(() => response.statusCode).thenReturn(200);
                when(() => response.body).thenReturn('{}');
                when(() => httpClient.get(any())).thenAnswer((_) async => response);

                await expectLater(repository.search(query), throwsA(isA<client.LocationNotFoundFailure>()));
            });

            test('throws LocationNotFoundFailure on empty response', () async {
                final response = MockResponse();
                when(() => response.statusCode).thenReturn(200);
                when(() => response.body).thenReturn('{"results": []}');
                when(() => httpClient.get(any())).thenAnswer((_) async => response);

                await expectLater(repository.search(query), throwsA(isA<client.LocationNotFoundFailure>()));
            });

            test('returns Location on valid response', () async {
                final response = MockResponse();
                when(() => response.statusCode).thenReturn(200);
                when(() => response.body).thenReturn(__citiesResponse);
                when(() => httpClient.get(any())).thenAnswer((_) async => response);

                final actual = await repository.search(query);
                expect(actual, isA<List<City>>());
            });
        });

        group('getWeather', () {
            const citySample = City(name: "Chicago", elevation: 2.4, country: "America", latitude: 41.85003, longitude: -87.65005);
            test('throws WeatherRequestFailure on non-200 response', () async {
                final response = MockResponse();
                when(() => response.statusCode).thenReturn(400);
                when(() => httpClient.get(any())).thenAnswer((_) async => response);
                expect(() async => repository.getWeather(citySample),
                    throwsA(isA<client.WeatherRequestFailure>()),
                );
            });

            test('throws WeatherNotFoundFailure on empty response', () async {
                final response = MockResponse();
                when(() => response.statusCode).thenReturn(200);
                when(() => response.body).thenReturn('{}');
                when(() => httpClient.get(any())).thenAnswer((_) async => response);
                expect(() async => repository.getWeather(citySample),
                    throwsA(isA<client.WeatherNotFoundFailure>()),
                );
            });

            test('returns weather on valid response', () async {
                final json = jsonDecode(__resultResponse);

                final response = MockResponse();
                when(() => response.statusCode).thenReturn(200);
                when(() => response.body).thenReturn(__resultResponse);
                when(() => httpClient.get(any())).thenAnswer((_) async => response);

                final actual = await repository.getWeather(citySample);
                expect(actual,
                    isA<City>()
                        .having((c) => c.name, 'City Name', citySample.name)
                        .having((c) => c.country, 'Country', citySample.country)
                        .having((c) => c.elevation, 'Elevation', 38)
                        .having((c) => c.timezone, 'Time Zone', "GMT")
                        .having((c) => c.longitude, 'Longitude', 13.419998)
                        .having((c) => c.latitude, 'Latitude', 52.52)
                        .having((c) => c.forecast?.utc_offset_seconds, 'UTC Offset',  0)
                        .having((c) => c.forecast?.current != null, 'Current', true)
                        .having((c) => c.forecast?.daily != null && c.forecast?.daily is List<Daily>, 'Daily', true)
                        .having((c) => c.forecast?.hourly != null && c.forecast?.hourly is List<Hourly>, 'Hourly', true)
                );
            });
        });
    });
}