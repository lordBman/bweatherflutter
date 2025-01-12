import 'dart:convert';

import 'package:bweather_repository/models/forecast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    group('Value', () {
        group('Constructor', () {
            test('returns an instance Vaue object from Constructor', () {
                expect(const Value<double>(value: 32.2, unit: "mm"),
                    isA<Value>()
                        .having((w) => w.value, 'Actual Value', 32.2)
                        .having((w) => w.unit, 'Unit of Value', 'mm'));
            });
        });

        group('fromJson', () {
            test('returns correct Value object from json map', () {
                expect(Value<double>.fromJson(const { 'value': 32.2, "unit": "mm" }),
                    isA<Value<double>>()
                        .having((w) => w.value, 'Actual Value', 32.2)
                        .having((w) => w.unit, 'Unit of Value', 'mm'));
            });

            test('returns correct Value object from json String', () {
                expect(Value<double>.fromJson(jsonDecode('{ "value": 32.2, "unit": "mm" }')),
                    isA<Value<double>>()
                        .having((w) => w.value, 'Actual Value', 32.2)
                        .having((w) => w.unit, 'Unit of Value', 'mm'));
            });

            test('Value<T> should serialize to a JSON string correctly', () {
                const value = Value<int>(value: 100, unit: "units");
                final serialized = value.serialize();
                expect(serialized, '{"value":100,"unit":"units"}');
            });

            test('Value<T> should support equality comparison', () {
                const value1 = Value<int>(value: 100, unit: "units");
                const value2 = Value<int>(value: 100, unit: "units");
                const value3 = Value<int>(value: 200, unit: "units");
                expect(value1 == value2, true);
                expect(value1 == value3, false);
            });
        });

        group('toJson', () {
            test('returns a map json of Value object', () {
                expect(const Value<double>(value: 32.2, unit: "mm").toJson(),
                    isA<Map<String, dynamic>>()
                        .having((c) => c["value"], "Actual Value", 32.2)
                        .having((c) => c["unit"], 'Unit of Value', 'mm'));
            });
        });

        test('Value objects are equal if they have the same values', () {
            expect(const Value<double>(value: 32.2, unit: "mm"), const Value<double>(value: 32.2, unit: "mm"));
        });
    });
}