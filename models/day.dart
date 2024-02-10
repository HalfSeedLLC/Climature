import 'dart:convert';
import 'air_quality.dart';
import 'condition.dart';

class Day {
  Day({
    required this.maxTempC,
    required this.maxTempF,
    required this.minTempC,
    required this.minTempF,
    required this.avgTempC,
    required this.avgTempF,
    required this.maxWindMph,
    required this.maxWindKph,
    required this.totalPrecipitationMm,
    required this.totalPrecipitationIn,
    required this.totalSnowCm,
    required this.averageVisibilityKm,
    required this.averageVisibilityM,
    required this.averageHumidity,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
    required this.airQuality,
  });

  final double maxTempC;
  final double maxTempF;
  final double minTempC;
  final double minTempF;
  final double avgTempC;
  final double avgTempF;
  final double maxWindMph;
  final double maxWindKph;
  final double totalPrecipitationMm;
  final double totalPrecipitationIn;
  final double totalSnowCm;
  final double averageVisibilityKm;
  final double averageVisibilityM;
  final int averageHumidity;
  final bool dailyWillItRain;
  final int dailyChanceOfRain;
  final bool dailyWillItSnow;
  final int dailyChanceOfSnow;
  final Condition condition;
  final double uv;
  final AirQuality airQuality;

  Day copyWith({
    double? maxTempC,
    double? maxTempF,
    double? minTempC,
    double? minTempF,
    double? avgTempC,
    double? avgTempF,
    double? maxWindMph,
    double? maxWindKph,
    double? totalPrecipitationMm,
    double? totalPrecipitationIn,
    double? totalSnowCm,
    double? averageVisibilityKm,
    double? averageVisibilityM,
    int? averageHumidity,
    bool? dailyWillItRain,
    int? dailyChanceOfRain,
    bool? dailyWillItSnow,
    int? dailyChanceOfSnow,
    Condition? condition,
    double? uv,
    AirQuality? airQuality,
  }) {
    return Day(
      maxTempC: maxTempC ?? this.maxTempC,
      maxTempF: maxTempF ?? this.maxTempF,
      minTempC: minTempC ?? this.minTempC,
      minTempF: minTempF ?? this.minTempF,
      avgTempC: avgTempC ?? this.avgTempC,
      avgTempF: avgTempF ?? this.avgTempF,
      maxWindMph: maxWindMph ?? this.maxWindMph,
      maxWindKph: maxWindKph ?? this.maxWindKph,
      totalPrecipitationMm: totalPrecipitationMm ?? this.totalPrecipitationMm,
      totalPrecipitationIn: totalPrecipitationIn ?? this.totalPrecipitationIn,
      totalSnowCm: totalSnowCm ?? this.totalSnowCm,
      averageVisibilityKm: averageVisibilityKm ?? this.averageVisibilityKm,
      averageVisibilityM: averageVisibilityM ?? this.averageVisibilityM,
      averageHumidity: averageHumidity ?? this.averageHumidity,
      dailyWillItRain: dailyWillItRain ?? this.dailyWillItRain,
      dailyChanceOfRain: dailyChanceOfRain ?? this.dailyChanceOfRain,
      dailyWillItSnow: dailyWillItSnow ?? this.dailyWillItSnow,
      dailyChanceOfSnow: dailyChanceOfSnow ?? this.dailyChanceOfSnow,
      condition: condition ?? this.condition,
      uv: uv ?? this.uv,
      airQuality: airQuality ?? this.airQuality,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'maxTempC': maxTempC,
      'maxTempF': maxTempF,
      'minTempC': minTempC,
      'minTempF': minTempF,
      'avgTempC': avgTempC,
      'avgTempF': avgTempF,
      'maxWindMph': maxWindMph,
      'maxWindKph': maxWindKph,
      'totalPrecipitationMm': totalPrecipitationMm,
      'totalPrecipitationIn': totalPrecipitationIn,
      'totalSnowCm': totalSnowCm,
      'averageVisibilityKm': averageVisibilityKm,
      'averageVisibilityM': averageVisibilityM,
      'averageHumidity': averageHumidity,
      'dailyWillItRain': dailyWillItRain,
      'dailyChanceOfRain': dailyChanceOfRain,
      'dailyWillItSnow': dailyWillItSnow,
      'dailyChanceOfSnow': dailyChanceOfSnow,
      'condition': condition.toMap(),
      'uv': uv,
      'airQuality': airQuality.toMap(),
    };
  }

  factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      maxTempC: map['maxTempC'] as double,
      maxTempF: map['maxTempF'] as double,
      minTempC: map['minTempC'] as double,
      minTempF: map['minTempF'] as double,
      avgTempC: map['avgTempC'] as double,
      avgTempF: map['avgTempF'] as double,
      maxWindMph: map['maxWindMph'] as double,
      maxWindKph: map['maxWindKph'] as double,
      totalPrecipitationMm: map['totalPrecipitationMm'] as double,
      totalPrecipitationIn: map['totalPrecipitationIn'] as double,
      totalSnowCm: map['totalSnowCm'] as double,
      averageVisibilityKm: map['averageVisibilityKm'] as double,
      averageVisibilityM: map['averageVisibilityM'] as double,
      averageHumidity: map['averageHumidity'] as int,
      dailyWillItRain: map['dailyWillItRain'] as bool,
      dailyChanceOfRain: map['dailyChanceOfRain'] as int,
      dailyWillItSnow: map['dailyWillItSnow'] as bool,
      dailyChanceOfSnow: map['dailyChanceOfSnow'] as int,
      condition: Condition.fromMap(map['condition'] as Map<String, dynamic>),
      uv: map['uv'] as double,
      airQuality: AirQuality.fromMap(map['airQuality'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Day.fromJson(String source) =>
      Day.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Day(maxTempC: $maxTempC, maxTempF: $maxTempF, minTempC: $minTempC, minTempF: $minTempF, avgTempC: $avgTempC, avgTempF: $avgTempF, maxWindMph: $maxWindMph, maxWindKph: $maxWindKph, totalPrecipitationMm: $totalPrecipitationMm, totalPrecipitationIn: $totalPrecipitationIn, totalSnowCm: $totalSnowCm, averageVisibilityKm: $averageVisibilityKm, averageVisibilityM: $averageVisibilityM, averageHumidity: $averageHumidity, dailyWillItRain: $dailyWillItRain, dailyChanceOfRain: $dailyChanceOfRain, dailyWillItSnow: $dailyWillItSnow, dailyChanceOfSnow: $dailyChanceOfSnow, condition: $condition, uv: $uv, airQuality: $airQuality)';
  }

  @override
  bool operator ==(covariant Day other) {
    if (identical(this, other)) return true;

    return other.maxTempC == maxTempC &&
        other.maxTempF == maxTempF &&
        other.minTempC == minTempC &&
        other.minTempF == minTempF &&
        other.avgTempC == avgTempC &&
        other.avgTempF == avgTempF &&
        other.maxWindMph == maxWindMph &&
        other.maxWindKph == maxWindKph &&
        other.totalPrecipitationMm == totalPrecipitationMm &&
        other.totalPrecipitationIn == totalPrecipitationIn &&
        other.totalSnowCm == totalSnowCm &&
        other.averageVisibilityKm == averageVisibilityKm &&
        other.averageVisibilityM == averageVisibilityM &&
        other.averageHumidity == averageHumidity &&
        other.dailyWillItRain == dailyWillItRain &&
        other.dailyChanceOfRain == dailyChanceOfRain &&
        other.dailyWillItSnow == dailyWillItSnow &&
        other.dailyChanceOfSnow == dailyChanceOfSnow &&
        other.condition == condition &&
        other.uv == uv &&
        other.airQuality == airQuality;
  }

  @override
  int get hashCode {
    return maxTempC.hashCode ^
        maxTempF.hashCode ^
        minTempC.hashCode ^
        minTempF.hashCode ^
        avgTempC.hashCode ^
        avgTempF.hashCode ^
        maxWindMph.hashCode ^
        maxWindKph.hashCode ^
        totalPrecipitationMm.hashCode ^
        totalPrecipitationIn.hashCode ^
        totalSnowCm.hashCode ^
        averageVisibilityKm.hashCode ^
        averageVisibilityM.hashCode ^
        averageHumidity.hashCode ^
        dailyWillItRain.hashCode ^
        dailyChanceOfRain.hashCode ^
        dailyWillItSnow.hashCode ^
        dailyChanceOfSnow.hashCode ^
        condition.hashCode ^
        uv.hashCode ^
        airQuality.hashCode;
  }
}
