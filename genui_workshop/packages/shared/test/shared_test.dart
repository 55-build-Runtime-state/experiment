import 'dart:convert';
import 'dart:io';

import 'package:shared/shared.dart';
import 'package:test/test.dart';

void main() {
  group('JSON Parsing', () {
    test('Parses Detroit.json successfully', () {
      final file = File('test/Detroit.json');
      final jsonString = file.readAsStringSync();
      final jsonMap = jsonDecode(jsonString);

      final forecast = Forecast.fromJson(jsonMap);
      print(forecast.toJson());

      expect(forecast.nearestArea, isNotNull);
      expect(forecast.currentCondition, isNotNull);
    });

    test('Parses pirateweather.json successfully', () {
      final file = File('test/pirateweather.json');
      final jsonString = file.readAsStringSync();
      final jsonMap = jsonDecode(jsonString);

      final pirateForecast = PirateForecast.fromJson(jsonMap);

      // Verify the location extraction
      final nearestArea = pirateForecast.nearestArea;
      expect(nearestArea.areaName, equals('Ottawa'));
      expect(nearestArea.region, equals('Ontario'));
      expect(nearestArea.country, equals('Canada'));
      expect(nearestArea.fullLocation, equals('Ottawa, Ontario, Canada'));

      // Verify the daily forecast
      expect(pirateForecast.daily, isNotNull);
      expect(pirateForecast.daily.data, isNotEmpty);
      expect(pirateForecast.daily.data.first.time, isNotNull);
      expect(pirateForecast.daily.data.first.temperatureHigh, isNotNull);
    });
  });
}
