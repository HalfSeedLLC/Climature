import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'current.dart';
import 'forecast_day.dart';
import 'location.dart';

class Forecast {
  Forecast({
    required this.location,
    required this.current,
    required this.forecastDays,
  });

  final Location location;
  final Current current;
  final List<ForecastDay> forecastDays;

  Forecast copyWith({
    Location? location,
    Current? current,
    List<ForecastDay>? forecastDays,
  }) {
    return Forecast(
      location: location ?? this.location,
      current: current ?? this.current,
      forecastDays: forecastDays ?? this.forecastDays,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
      'current': current.toMap(),
      'forecastDays': forecastDays.map((x) => x.toMap()).toList(),
    };
  }

  factory Forecast.fromMap(Map<String, dynamic> map) {
    return Forecast(
      location: Location.fromMap(map['location'] as Map<String, dynamic>),
      current: Current.fromMap(map['current'] as Map<String, dynamic>),
      forecastDays: List<ForecastDay>.from(
        (map['forecastDays'] as List<int>).map<ForecastDay>(
          (x) => ForecastDay.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Forecast.fromJson(String source) =>
      Forecast.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Forecast(location: $location, current: $current, forecastDays: $forecastDays)';

  @override
  bool operator ==(covariant Forecast other) {
    if (identical(this, other)) return true;

    return other.location == location &&
        other.current == current &&
        listEquals(other.forecastDays, forecastDays);
  }

  @override
  int get hashCode =>
      location.hashCode ^ current.hashCode ^ forecastDays.hashCode;
}
