import 'dart:convert';

import 'current.dart';
import 'location.dart';

class WeatherCardData {
  WeatherCardData({
    required this.location,
    required this.current,
  });

  final Location location;
  final Current current;

  WeatherCardData copyWith({
    Location? location,
    Current? current,
  }) {
    return WeatherCardData(
      location: location ?? this.location,
      current: current ?? this.current,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
      'current': current.toMap(),
    };
  }

  factory WeatherCardData.fromMap(Map<String, dynamic> map) {
    return WeatherCardData(
      location: Location.fromMap(map['location'] as Map<String, dynamic>),
      current: Current.fromMap(map['current'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherCardData.fromJson(String source) =>
      WeatherCardData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WeatherCardData(location: $location, current: $current)';

  @override
  bool operator ==(covariant WeatherCardData other) {
    if (identical(this, other)) return true;

    return other.location == location && other.current == current;
  }

  @override
  int get hashCode => location.hashCode ^ current.hashCode;
}
