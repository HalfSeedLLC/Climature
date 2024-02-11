import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'current.dart';
import 'forecast_day.dart';
import 'location.dart';

class Forecast {
  Forecast({
    required this.location,
    required this.current,
    required this.forecast,
  });

  final Location location;
  final Current current;
  final Map<String, List<ForecastDay>> forecast;

  Forecast copyWith({
    Location? location,
    Current? current,
    Map<String, List<ForecastDay>>? forecast,
  }) {
    return Forecast(
      location: location ?? this.location,
      current: current ?? this.current,
      forecast: forecast ?? this.forecast,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
      'current': current.toMap(),
      'forecast': forecast,
    };
  }

  factory Forecast.fromMap(Map<String, dynamic> map) {
    return Forecast(
      location: Location.fromMap(map['location'] as Map<String, dynamic>),
      current: Current.fromMap(map['current'] as Map<String, dynamic>),
      forecast: Map<String, List<dynamic>>.from(
              map['forecast'] as Map<String, dynamic>)
          .map(
        (key, value) => MapEntry(
          key,
          (value)
              .map((e) => ForecastDay.fromMap(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Forecast.fromJson(String source) =>
      Forecast.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Forecast(location: $location, current: $current, forecast: $forecast)';

  @override
  bool operator ==(covariant Forecast other) {
    if (identical(this, other)) return true;

    return other.location == location &&
        other.current == current &&
        mapEquals(other.forecast, forecast);
  }

  @override
  int get hashCode => location.hashCode ^ current.hashCode ^ forecast.hashCode;
}
