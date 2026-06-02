import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

// From wttr.in

@JsonSerializable(ignoreUnannotated: true, explicitToJson: true)
class Forecast {
  @JsonKey(name: 'nearest_area', fromJson: _extractNearestArea)
  final NearestArea nearestArea;

  @JsonKey(name: 'current_condition', fromJson: _extractCurrentCondition)
  final CurrentCondition currentCondition;

  Forecast({required this.nearestArea, required this.currentCondition});

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastToJson(this);
}

NearestArea _extractNearestArea(List<dynamic> list) =>
    NearestArea.fromJson(list.first as Map<String, dynamic>);

CurrentCondition _extractCurrentCondition(List<dynamic> list) =>
    CurrentCondition.fromJson(list.first as Map<String, dynamic>);

@JsonSerializable(ignoreUnannotated: true)
class NearestArea {
  @JsonKey(fromJson: double.parse)
  double latitude;

  @JsonKey(fromJson: double.parse)
  double longitude;

  @JsonKey(fromJson: _extractValueFromList)
  final String areaName;

  @JsonKey(fromJson: _extractValueFromList)
  final String region;

  @JsonKey(fromJson: _extractValueFromList)
  final String country;

  NearestArea({
    required this.latitude,
    required this.longitude,
    required this.areaName,
    required this.region,
    required this.country,
  });

  String get fullLocation => '$areaName, $region, $country';

  factory NearestArea.fromJson(Map<String, dynamic> json) =>
      _$NearestAreaFromJson(json);

  Map<String, dynamic> toJson() => _$NearestAreaToJson(this);
}

String _extractValueFromList(List<dynamic> list) =>
    (list.first as Map<String, dynamic>)['value'] as String;

@JsonSerializable(ignoreUnannotated: true)
class CurrentCondition {
  @JsonKey(fromJson: double.parse)
  final double FeelsLikeC;

  @JsonKey(fromJson: double.parse)
  final double FeelsLikeF;

  @JsonKey(fromJson: double.parse)
  final double cloudcover;

  @JsonKey(fromJson: double.parse)
  final double humidity;

  @JsonKey()
  final String observation_time;

  @JsonKey(fromJson: double.parse)
  final double precipInches;

  @JsonKey(fromJson: double.parse)
  final double precipMM;

  @JsonKey(fromJson: double.parse)
  final double pressure;

  @JsonKey(fromJson: double.parse)
  final double pressureInches;

  @JsonKey(fromJson: double.parse)
  final double temp_C;

  @JsonKey(fromJson: double.parse)
  final double temp_F;

  @JsonKey(fromJson: double.parse)
  final double uvIndex;

  @JsonKey(fromJson: double.parse)
  final double visibility;

  @JsonKey(fromJson: double.parse)
  final double visibilityMiles;

  @JsonKey()
  final String weatherCode;

  @JsonKey(fromJson: _extractValueFromList)
  final String weatherDesc;

  @JsonKey(fromJson: _extractValueFromList)
  final String weatherIconUrl;

  @JsonKey()
  final String winddir16Point;

  @JsonKey(fromJson: double.parse)
  final double winddirDegree;

  @JsonKey(fromJson: double.parse)
  final double windspeedKmph;

  @JsonKey(fromJson: double.parse)
  final double windspeedMiles;

  CurrentCondition({
    required this.FeelsLikeC,
    required this.FeelsLikeF,
    required this.cloudcover,
    required this.humidity,
    required this.observation_time,
    required this.precipInches,
    required this.precipMM,
    required this.pressure,
    required this.pressureInches,
    required this.temp_C,
    required this.temp_F,
    required this.uvIndex,
    required this.visibility,
    required this.visibilityMiles,
    required this.weatherCode,
    required this.weatherDesc,
    required this.weatherIconUrl,
    required this.winddir16Point,
    required this.winddirDegree,
    required this.windspeedKmph,
    required this.windspeedMiles,
  });

  factory CurrentCondition.fromJson(Map<String, dynamic> json) =>
      _$CurrentConditionFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentConditionToJson(this);
}

// From PirateWeather

@JsonSerializable(ignoreUnannotated: true, explicitToJson: true)
class PirateForecast {
  @JsonKey()
  final double latitude;

  @JsonKey()
  final double longitude;

  @JsonKey()
  final PirateFlags flags;

  @JsonKey()
  final PirateDaily daily;

  // Set at runtime based on the URL request
  String units = 'imperial'; // or 'metric'

  PirateForecast({
    required this.latitude,
    required this.longitude,
    required this.flags,
    required this.daily,
  });

  NearestArea get nearestArea => NearestArea(
        latitude: latitude,
        longitude: longitude,
        areaName: flags.nearestCity,
        region: flags.nearestSubNational,
        country: flags.nearestCountry,
      );

  factory PirateForecast.fromJson(Map<String, dynamic> json) =>
      _$PirateForecastFromJson(json);

  Map<String, dynamic> toJson() => _$PirateForecastToJson(this);
}

@JsonSerializable(ignoreUnannotated: true, explicitToJson: true)
class PirateDaily {
  @JsonKey()
  final String summary;

  @JsonKey()
  final String icon;

  @JsonKey()
  final List<PirateDailyData> data;

  PirateDaily({
    required this.summary,
    required this.icon,
    required this.data,
  });

  factory PirateDaily.fromJson(Map<String, dynamic> json) =>
      _$PirateDailyFromJson(json);

  Map<String, dynamic> toJson() => _$PirateDailyToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class PirateFlags {
  @JsonKey()
  final String nearestCity;

  @JsonKey()
  final String nearestSubNational;

  @JsonKey()
  final String nearestCountry;

  PirateFlags({
    required this.nearestCity,
    required this.nearestSubNational,
    required this.nearestCountry,
  });

  factory PirateFlags.fromJson(Map<String, dynamic> json) =>
      _$PirateFlagsFromJson(json);

  Map<String, dynamic> toJson() => _$PirateFlagsToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class PirateDailyData {
  @JsonKey()
  final int time;

  @JsonKey()
  final String summary;

  @JsonKey()
  final String icon;

  @JsonKey()
  final double sunriseTime;

  @JsonKey()
  final double sunsetTime;

  @JsonKey()
  final double precipProbability;

  @JsonKey()
  final double temperatureHigh;

  @JsonKey()
  final double temperatureLow;

  @JsonKey()
  final double humidity;

  @JsonKey()
  final double windSpeed;

  @JsonKey()
  final double uvIndex;

  PirateDailyData({
    required this.time,
    required this.summary,
    required this.icon,
    required this.sunriseTime,
    required this.sunsetTime,
    required this.precipProbability,
    required this.temperatureHigh,
    required this.temperatureLow,
    required this.humidity,
    required this.windSpeed,
    required this.uvIndex,
  });

  factory PirateDailyData.fromJson(Map<String, dynamic> json) =>
      _$PirateDailyDataFromJson(json);

  Map<String, dynamic> toJson() => _$PirateDailyDataToJson(this);
}
