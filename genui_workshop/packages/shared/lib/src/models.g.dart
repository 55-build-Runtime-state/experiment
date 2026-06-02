// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Forecast _$ForecastFromJson(Map<String, dynamic> json) => Forecast(
  nearestArea: _extractNearestArea(json['nearest_area'] as List),
  currentCondition: _extractCurrentCondition(json['current_condition'] as List),
);

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
  'nearest_area': instance.nearestArea.toJson(),
  'current_condition': instance.currentCondition.toJson(),
};

NearestArea _$NearestAreaFromJson(Map<String, dynamic> json) => NearestArea(
  latitude: double.parse(json['latitude'] as String),
  longitude: double.parse(json['longitude'] as String),
  areaName: _extractValueFromList(json['areaName'] as List),
  region: _extractValueFromList(json['region'] as List),
  country: _extractValueFromList(json['country'] as List),
);

Map<String, dynamic> _$NearestAreaToJson(NearestArea instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'areaName': instance.areaName,
      'region': instance.region,
      'country': instance.country,
    };

CurrentCondition _$CurrentConditionFromJson(Map<String, dynamic> json) =>
    CurrentCondition(
      FeelsLikeC: double.parse(json['FeelsLikeC'] as String),
      FeelsLikeF: double.parse(json['FeelsLikeF'] as String),
      cloudcover: double.parse(json['cloudcover'] as String),
      humidity: double.parse(json['humidity'] as String),
      observation_time: json['observation_time'] as String,
      precipInches: double.parse(json['precipInches'] as String),
      precipMM: double.parse(json['precipMM'] as String),
      pressure: double.parse(json['pressure'] as String),
      pressureInches: double.parse(json['pressureInches'] as String),
      temp_C: double.parse(json['temp_C'] as String),
      temp_F: double.parse(json['temp_F'] as String),
      uvIndex: double.parse(json['uvIndex'] as String),
      visibility: double.parse(json['visibility'] as String),
      visibilityMiles: double.parse(json['visibilityMiles'] as String),
      weatherCode: json['weatherCode'] as String,
      weatherDesc: _extractValueFromList(json['weatherDesc'] as List),
      weatherIconUrl: _extractValueFromList(json['weatherIconUrl'] as List),
      winddir16Point: json['winddir16Point'] as String,
      winddirDegree: double.parse(json['winddirDegree'] as String),
      windspeedKmph: double.parse(json['windspeedKmph'] as String),
      windspeedMiles: double.parse(json['windspeedMiles'] as String),
    );

Map<String, dynamic> _$CurrentConditionToJson(CurrentCondition instance) =>
    <String, dynamic>{
      'FeelsLikeC': instance.FeelsLikeC,
      'FeelsLikeF': instance.FeelsLikeF,
      'cloudcover': instance.cloudcover,
      'humidity': instance.humidity,
      'observation_time': instance.observation_time,
      'precipInches': instance.precipInches,
      'precipMM': instance.precipMM,
      'pressure': instance.pressure,
      'pressureInches': instance.pressureInches,
      'temp_C': instance.temp_C,
      'temp_F': instance.temp_F,
      'uvIndex': instance.uvIndex,
      'visibility': instance.visibility,
      'visibilityMiles': instance.visibilityMiles,
      'weatherCode': instance.weatherCode,
      'weatherDesc': instance.weatherDesc,
      'weatherIconUrl': instance.weatherIconUrl,
      'winddir16Point': instance.winddir16Point,
      'winddirDegree': instance.winddirDegree,
      'windspeedKmph': instance.windspeedKmph,
      'windspeedMiles': instance.windspeedMiles,
    };

PirateForecast _$PirateForecastFromJson(Map<String, dynamic> json) =>
    PirateForecast(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      flags: PirateFlags.fromJson(json['flags'] as Map<String, dynamic>),
      daily: PirateDaily.fromJson(json['daily'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PirateForecastToJson(PirateForecast instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'flags': instance.flags.toJson(),
      'daily': instance.daily.toJson(),
    };

PirateDaily _$PirateDailyFromJson(Map<String, dynamic> json) => PirateDaily(
  summary: json['summary'] as String,
  icon: json['icon'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => PirateDailyData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PirateDailyToJson(PirateDaily instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'icon': instance.icon,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

PirateFlags _$PirateFlagsFromJson(Map<String, dynamic> json) => PirateFlags(
  nearestCity: json['nearestCity'] as String,
  nearestSubNational: json['nearestSubNational'] as String,
  nearestCountry: json['nearestCountry'] as String,
);

Map<String, dynamic> _$PirateFlagsToJson(PirateFlags instance) =>
    <String, dynamic>{
      'nearestCity': instance.nearestCity,
      'nearestSubNational': instance.nearestSubNational,
      'nearestCountry': instance.nearestCountry,
    };

PirateDailyData _$PirateDailyDataFromJson(Map<String, dynamic> json) =>
    PirateDailyData(
      time: (json['time'] as num).toInt(),
      summary: json['summary'] as String,
      icon: json['icon'] as String,
      sunriseTime: (json['sunriseTime'] as num).toDouble(),
      sunsetTime: (json['sunsetTime'] as num).toDouble(),
      precipProbability: (json['precipProbability'] as num).toDouble(),
      temperatureHigh: (json['temperatureHigh'] as num).toDouble(),
      temperatureLow: (json['temperatureLow'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      uvIndex: (json['uvIndex'] as num).toDouble(),
    );

Map<String, dynamic> _$PirateDailyDataToJson(PirateDailyData instance) =>
    <String, dynamic>{
      'time': instance.time,
      'summary': instance.summary,
      'icon': instance.icon,
      'sunriseTime': instance.sunriseTime,
      'sunsetTime': instance.sunsetTime,
      'precipProbability': instance.precipProbability,
      'temperatureHigh': instance.temperatureHigh,
      'temperatureLow': instance.temperatureLow,
      'humidity': instance.humidity,
      'windSpeed': instance.windSpeed,
      'uvIndex': instance.uvIndex,
    };
