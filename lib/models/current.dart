import 'dart:convert';

import 'air_quality.dart';
import 'condition.dart';

class Current {
  Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipitationMm,
    required this.precipitationIn,
    required this.humidity,
    required this.cloud,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.visibilityKilometers,
    required this.visibilityMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
    required this.airQuality,
    this.itsDay,
  });

  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final int? itsDay;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipitationMm;
  final double precipitationIn;
  final int humidity;
  final int cloud;
  final double feelsLikeC;
  final double feelsLikeF;
  final double visibilityKilometers;
  final double visibilityMiles;
  final double uv;
  final double gustMph;
  final double gustKph;
  final AirQuality airQuality;

  Current copyWith({
    int? lastUpdatedEpoch,
    String? lastUpdated,
    double? tempC,
    double? tempF,
    int? itsDay,
    Condition? condition,
    double? windMph,
    double? windKph,
    int? windDegree,
    String? windDir,
    double? pressureMb,
    double? pressureIn,
    double? precipitationMm,
    double? precipitationIn,
    int? humidity,
    int? cloud,
    double? feelsLikeC,
    double? feelsLikeF,
    double? visibilityKilometers,
    double? visibilityMiles,
    double? uv,
    double? gustMph,
    double? gustKph,
    AirQuality? airQuality,
  }) {
    return Current(
      lastUpdatedEpoch: lastUpdatedEpoch ?? this.lastUpdatedEpoch,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      tempC: tempC ?? this.tempC,
      tempF: tempF ?? this.tempF,
      itsDay: itsDay ?? this.itsDay,
      condition: condition ?? this.condition,
      windMph: windMph ?? this.windMph,
      windKph: windKph ?? this.windKph,
      windDegree: windDegree ?? this.windDegree,
      windDir: windDir ?? this.windDir,
      pressureMb: pressureMb ?? this.pressureMb,
      pressureIn: pressureIn ?? this.pressureIn,
      precipitationMm: precipitationMm ?? this.precipitationMm,
      precipitationIn: precipitationIn ?? this.precipitationIn,
      humidity: humidity ?? this.humidity,
      cloud: cloud ?? this.cloud,
      feelsLikeC: feelsLikeC ?? this.feelsLikeC,
      feelsLikeF: feelsLikeF ?? this.feelsLikeF,
      visibilityKilometers: visibilityKilometers ?? this.visibilityKilometers,
      visibilityMiles: visibilityMiles ?? this.visibilityMiles,
      uv: uv ?? this.uv,
      gustMph: gustMph ?? this.gustMph,
      gustKph: gustKph ?? this.gustKph,
      airQuality: airQuality ?? this.airQuality,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastUpdatedEpoch': lastUpdatedEpoch,
      'lastUpdated': lastUpdated,
      'tempC': tempC,
      'tempF': tempF,
      'itsDay': itsDay,
      'condition': condition.toMap(),
      'windMph': windMph,
      'windKph': windKph,
      'windDegree': windDegree,
      'windDir': windDir,
      'pressureMb': pressureMb,
      'pressureIn': pressureIn,
      'precipitationMm': precipitationMm,
      'precipitationIn': precipitationIn,
      'humidity': humidity,
      'cloud': cloud,
      'feelsLikeC': feelsLikeC,
      'feelsLikeF': feelsLikeF,
      'visibilityKilometers': visibilityKilometers,
      'visibilityMiles': visibilityMiles,
      'uv': uv,
      'gustMph': gustMph,
      'gustKph': gustKph,
      'airQuality': airQuality.toMap(),
    };
  }

  factory Current.fromMap(Map<String, dynamic> map) {
    return Current(
      lastUpdatedEpoch: map['last_updated_epoch'] as int? ?? 0,
      lastUpdated: map['last_updated'] as String? ?? '',
      tempC: (map['temp_c'] as num?)?.toDouble() ?? 0,
      tempF: (map['temp_f'] as num?)?.toDouble() ?? 0,
      itsDay: map['its_day'] as int? ?? 0,
      condition: map['condition'] != null
          ? Condition.fromMap(map['condition'] as Map<String, dynamic>)
          : Condition(
              text: '',
              icon: '',
              code: 0,
            ),
      windMph: (map['wind_mph'] as num?)?.toDouble() ?? 0,
      windKph: (map['wind_kph'] as num?)?.toDouble() ?? 0,
      windDegree: map['wind_degree'] as int? ?? 0,
      windDir: map['wind_dir'] as String? ?? '',
      pressureMb: (map['pressure_mb'] as num?)?.toDouble() ?? 0,
      pressureIn: (map['pressure_in'] as num?)?.toDouble() ?? 0,
      precipitationMm: (map['precip_mm'] as num?)?.toDouble() ?? 0,
      precipitationIn: (map['precip_in'] as num?)?.toDouble() ?? 0,
      humidity: map['humidity'] as int? ?? 0,
      cloud: map['cloud'] as int? ?? 0,
      feelsLikeC: (map['feelslike_c'] as num?)?.toDouble() ?? 0,
      feelsLikeF: (map['feelslike_f'] as num?)?.toDouble() ?? 0,
      visibilityKilometers: (map['vis_km'] as num?)?.toDouble() ?? 0,
      visibilityMiles: (map['vis_miles'] as num?)?.toDouble() ?? 0,
      uv: (map['uv'] as num?)?.toDouble() ?? 0,
      gustMph: (map['gust_mph'] as num?)?.toDouble() ?? 0,
      gustKph: (map['gust_kph'] as num?)?.toDouble() ?? 0,
      airQuality: map['air_quality'] != null
          ? AirQuality.fromMap(map['air_quality'] as Map<String, dynamic>)
          : AirQuality(
              co: 0,
              no2: 0,
              o3: 0,
              so2: 0,
              pm2_5: 0,
              pm10: 0,
              usEpaIndex: 0,
              gbDefraIndex: 0,
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Current.fromJson(String source) =>
      Current.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Current(lastUpdatedEpoch: $lastUpdatedEpoch, lastUpdated: $lastUpdated, tempC: $tempC, tempF: $tempF, itsDay: $itsDay, condition: $condition, windMph: $windMph, windKph: $windKph, windDegree: $windDegree, windDir: $windDir, pressureMb: $pressureMb, pressureIn: $pressureIn, precipitationMm: $precipitationMm, precipitationIn: $precipitationIn, humidity: $humidity, cloud: $cloud, feelsLikeC: $feelsLikeC, feelsLikeF: $feelsLikeF, visibilityKilometers: $visibilityKilometers, visibilityMiles: $visibilityMiles, uv: $uv, gustMph: $gustMph, gustKph: $gustKph, airQuality: $airQuality)';
  }

  @override
  bool operator ==(covariant Current other) {
    if (identical(this, other)) return true;

    return other.lastUpdatedEpoch == lastUpdatedEpoch &&
        other.lastUpdated == lastUpdated &&
        other.tempC == tempC &&
        other.tempF == tempF &&
        other.itsDay == itsDay &&
        other.condition == condition &&
        other.windMph == windMph &&
        other.windKph == windKph &&
        other.windDegree == windDegree &&
        other.windDir == windDir &&
        other.pressureMb == pressureMb &&
        other.pressureIn == pressureIn &&
        other.precipitationMm == precipitationMm &&
        other.precipitationIn == precipitationIn &&
        other.humidity == humidity &&
        other.cloud == cloud &&
        other.feelsLikeC == feelsLikeC &&
        other.feelsLikeF == feelsLikeF &&
        other.visibilityKilometers == visibilityKilometers &&
        other.visibilityMiles == visibilityMiles &&
        other.uv == uv &&
        other.gustMph == gustMph &&
        other.gustKph == gustKph &&
        other.airQuality == airQuality;
  }

  @override
  int get hashCode {
    return lastUpdatedEpoch.hashCode ^
        lastUpdated.hashCode ^
        tempC.hashCode ^
        tempF.hashCode ^
        itsDay.hashCode ^
        condition.hashCode ^
        windMph.hashCode ^
        windKph.hashCode ^
        windDegree.hashCode ^
        windDir.hashCode ^
        pressureMb.hashCode ^
        pressureIn.hashCode ^
        precipitationMm.hashCode ^
        precipitationIn.hashCode ^
        humidity.hashCode ^
        cloud.hashCode ^
        feelsLikeC.hashCode ^
        feelsLikeF.hashCode ^
        visibilityKilometers.hashCode ^
        visibilityMiles.hashCode ^
        uv.hashCode ^
        gustMph.hashCode ^
        gustKph.hashCode ^
        airQuality.hashCode;
  }
}
