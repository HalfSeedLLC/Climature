import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'astro.dart';
import 'day.dart';
import 'hour.dart';

class ForecastDay {
  ForecastDay({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hours,
  });

  final String date;
  final int dateEpoch;
  final Day day;
  final Astro astro;
  final List<Hour> hours;

  ForecastDay copyWith({
    String? date,
    int? dateEpoch,
    Day? day,
    Astro? astro,
    List<Hour>? hours,
  }) {
    return ForecastDay(
      date: date ?? this.date,
      dateEpoch: dateEpoch ?? this.dateEpoch,
      day: day ?? this.day,
      astro: astro ?? this.astro,
      hours: hours ?? this.hours,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'dateEpoch': dateEpoch,
      'day': day.toMap(),
      'astro': astro.toMap(),
      'hours': hours.map((x) => x.toMap()).toList(),
    };
  }

  factory ForecastDay.fromMap(Map<String, dynamic> map) {
    return ForecastDay(
      date: map['date'] as String,
      dateEpoch: map['date_epoch'] as int,
      day: Day.fromMap(map['day'] as Map<String, dynamic>),
      astro: Astro.fromMap(map['astro'] as Map<String, dynamic>),
      hours: (map['hours'] as List<dynamic>?)
              ?.map<Hour>(
                (hourMap) => Hour.fromMap(hourMap as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastDay.fromJson(String source) =>
      ForecastDay.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ForecastDay(date: $date, dateEpoch: $dateEpoch, day: $day, astro: $astro, hours: $hours)';
  }

  @override
  bool operator ==(covariant ForecastDay other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.dateEpoch == dateEpoch &&
        other.day == day &&
        other.astro == astro &&
        listEquals(other.hours, hours);
  }

  @override
  int get hashCode {
    return date.hashCode ^
        dateEpoch.hashCode ^
        day.hashCode ^
        astro.hashCode ^
        hours.hashCode;
  }
}
