import 'package:bweather_repository/units.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    group("Units", (){
        group("TempUnit", (){
          group('TempUnit extension tests', () {
            test('TempUnit should serialize to correct string', () {
              expect(TempUnit.fahrenheit.serialize, "fahrenheit");
              expect(TempUnit.celsius.serialize, "celsius");
            });

            test('String should deserialize to correct TempUnit', () {
              expect("fahrenheit".tempUnit, TempUnit.fahrenheit);
              expect("celsius".tempUnit, TempUnit.celsius);
            });

            test('String deserialization should throw an exception for invalid input', () {
              expect(() => "kelvin".tempUnit, throwsA(isA<Exception>()));
              expect(() => "".tempUnit, throwsA(isA<Exception>()));
            });

            test('String deserialization exception should include the invalid input', () {
              try {
                "kelvin".tempUnit;
              } catch (e) {
                expect(e.toString(), contains("kelvin is not a Temperature Unit"));
              }

              try {
                "".tempUnit;
              } catch (e) {
                expect(e.toString(), contains(" is not a Temperature Unit"));
              }
            });
          });
        });

        group("WindSpeedUnit", (){
          group('WindSpeedUnit extension tests', () {
            test('WindSpeedUnit should serialize to correct string', () {
              expect(WindSpeedUnit.ms.serialize, "ms");
              expect(WindSpeedUnit.mph.serialize, "mph");
              expect(WindSpeedUnit.kmh.serialize, "kmh");
              expect(WindSpeedUnit.kn.serialize, "kn");
            });

            test('String should deserialize to correct WindSpeedUnit', () {
              expect("ms".windSpeedUnit, WindSpeedUnit.ms);
              expect("mph".windSpeedUnit, WindSpeedUnit.mph);
              expect("kmh".windSpeedUnit, WindSpeedUnit.kmh);
              expect("kn".windSpeedUnit, WindSpeedUnit.kn);
            });

            test('String deserialization should throw an exception for invalid input', () {
              expect(() => "ft/s".windSpeedUnit, throwsA(isA<Exception>()));
              expect(() => "".windSpeedUnit, throwsA(isA<Exception>()));
            });

            test('String deserialization exception should include the invalid input', () {
              try {
                "ft/s".windSpeedUnit;
              } catch (e) {
                expect(e.toString(), contains("ft/s is not a Wind Speed Unit"));
              }

              try {
                "".windSpeedUnit;
              } catch (e) {
                expect(e.toString(), contains(" is not a Wind Speed Unit"));
              }
            });
          });
        });
        group('PrecipitationUnit extension tests', ()
        {
          test('PrecipitationUnit should serialize to correct string', () {
            expect(PrecipitationUnit.inch.serialize, "inch");
            expect(PrecipitationUnit.mm.serialize, "mm");
          });

          test('String should deserialize to correct PrecipitationUnit', () {
            expect("inch".precipitationUnit, PrecipitationUnit.inch);
            expect("mm".precipitationUnit, PrecipitationUnit.mm);
          });

          test(
              'String deserialization should throw an exception for invalid input', () {
            expect(() => "cm".precipitationUnit, throwsA(isA<Exception>()));
            expect(() => "".precipitationUnit, throwsA(isA<Exception>()));
          });

          test(
              'String deserialization exception should include the invalid input', () {
            try {
              "cm".precipitationUnit;
            } catch (e) {
              expect(e.toString(), contains("cm is not a Precipitation Unit"));
            }

            try {
              "".precipitationUnit;
            } catch (e) {
              expect(e.toString(), contains(" is not a Precipitation Unit"));
            }
          });
        });

        group('Units class tests', () {
          test('Default constructor should set default units', () {
            const units = Units();
            expect(units.temp_unit, TempUnit.celsius);
            expect(units.wind_speed_unit, WindSpeedUnit.ms);
            expect(units.precipitation_unit, PrecipitationUnit.mm);
          });

          test('Defaults constructor should set default units explicitly', () {
            const units = Units.defaults();
            expect(units.temp_unit, TempUnit.celsius);
            expect(units.wind_speed_unit, WindSpeedUnit.ms);
            expect(units.precipitation_unit, PrecipitationUnit.mm);
          });

          test('Serialization should produce correct JSON', () {
            const units = Units(
              temp_unit: TempUnit.fahrenheit,
              wind_speed_unit: WindSpeedUnit.mph,
              precipitation_unit: PrecipitationUnit.inch,
            );

            final json = units.toJson();
            expect(json['temp_unit'], 'fahrenheit');
            expect(json['wind_speed_unit'], 'mph');
            expect(json['precipitation_unit'], 'inch');
          });

          test('Deserialization should produce correct Units object', () {
            final json = {
              'temp_unit': 'celsius',
              'wind_speed_unit': 'kmh',
              'precipitation_unit': 'mm',
            };

            final units = Units.fromJson(json);

            expect(units.temp_unit, TempUnit.celsius);
            expect(units.wind_speed_unit, WindSpeedUnit.kmh);
            expect(units.precipitation_unit, PrecipitationUnit.mm);
          });

          test('Deserialization should throw an exception for invalid temp_unit', () {
            final json = {
              'temp_unit': 'kelvin',
              'wind_speed_unit': 'kmh',
              'precipitation_unit': 'mm',
            };

            expect(() => Units.fromJson(json), throwsA(isA<Exception>()));
          });

          test('Deserialization should throw an exception for invalid wind_speed_unit', () {
            final json = {
              'temp_unit': 'celsius',
              'wind_speed_unit': 'ft/s',
              'precipitation_unit': 'mm',
            };

            expect(() => Units.fromJson(json), throwsA(isA<Exception>()));
          });

          test('Deserialization should throw an exception for invalid precipitation_unit', () {
            final json = {
              'temp_unit': 'celsius',
              'wind_speed_unit': 'kmh',
              'precipitation_unit': 'liters',
            };

            expect(() => Units.fromJson(json), throwsA(isA<Exception>()));
          });

          test('Serialize method should produce correct JSON string', () {
            const units = Units(
              temp_unit: TempUnit.celsius,
              wind_speed_unit: WindSpeedUnit.kn,
              precipitation_unit: PrecipitationUnit.mm,
            );

            final serialized = units.serialize();
            expect(serialized, '{"temp_unit":"celsius","wind_speed_unit":"kn","precipitation_unit":"mm"}');
          });

          test('Copy method should create a new instance with updated fields', () {
            const units = Units(
              temp_unit: TempUnit.celsius,
              wind_speed_unit: WindSpeedUnit.ms,
              precipitation_unit: PrecipitationUnit.mm,
            );

            final copied = units.copy(temp_unit: TempUnit.fahrenheit, precipitation_unit: PrecipitationUnit.inch);

            expect(copied.temp_unit, TempUnit.fahrenheit);
            expect(copied.wind_speed_unit, WindSpeedUnit.ms);
            expect(copied.precipitation_unit, PrecipitationUnit.inch);
          });

          test('Copy method should retain all values if no arguments are provided', () {
            const original = Units(
              temp_unit: TempUnit.celsius,
              wind_speed_unit: WindSpeedUnit.ms,
              precipitation_unit: PrecipitationUnit.mm,
            );

            final copy = original.copy();

            expect(copy.temp_unit, original.temp_unit);
            expect(copy.wind_speed_unit, original.wind_speed_unit);
            expect(copy.precipitation_unit, original.precipitation_unit);
          });

          test('Units should remain immutable after copying', () {
            const units = Units(
              temp_unit: TempUnit.celsius,
              wind_speed_unit: WindSpeedUnit.ms,
              precipitation_unit: PrecipitationUnit.mm,
            );

            final copied = units.copy(temp_unit: TempUnit.fahrenheit);

            expect(units.temp_unit, TempUnit.celsius);
            expect(units.wind_speed_unit, WindSpeedUnit.ms);
            expect(units.precipitation_unit, PrecipitationUnit.mm);

            expect(copied.temp_unit, TempUnit.fahrenheit);
            expect(copied.wind_speed_unit, WindSpeedUnit.ms);
            expect(copied.precipitation_unit, PrecipitationUnit.mm);
          });
        });
    });
}
