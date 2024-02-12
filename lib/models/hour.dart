import 'dart:convert';
import 'air_quality.dart';

import 'condition.dart';

class Hour {
  Hour({
    required this.timeEpoch,
    required this.time,
    required this.tempC,
    required this.tempF,
    required this.itsDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipitationMm,
    required this.precipitationIn,
    required this.snowCm,
    required this.humidity,
    required this.cloud,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.windChillC,
    required this.windChillF,
    required this.heatIndexC,
    required this.heatIndexF,
    required this.dewPointC,
    required this.dewPointF,
    required this.willItRain,
    required this.chanceOfRain,
    required this.willItSnow,
    required this.chanceOfSnow,
    required this.visibilityKilometers,
    required this.visibilityMiles,
    required this.gustMph,
    required this.gustKph,
    required this.uv,
    required this.airQuality,
    required this.shortwaveSolarRadiation,
    required this.diffuseHorizontalRadiation,
  });

  final int timeEpoch;
  final String time;
  final double tempC;
  final double tempF;
  final int itsDay;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipitationMm;
  final double precipitationIn;
  final double snowCm;
  final int humidity;
  final int cloud;
  final double feelsLikeC;
  final double feelsLikeF;
  final double windChillC;
  final double windChillF;
  final double heatIndexC;
  final double heatIndexF;
  final double dewPointC;
  final double dewPointF;
  final bool willItRain;
  final int chanceOfRain;
  final bool willItSnow;
  final int chanceOfSnow;
  final double visibilityKilometers;
  final double visibilityMiles;
  final double gustMph;
  final double gustKph;
  final double uv;
  final AirQuality airQuality;
  final double shortwaveSolarRadiation;
  final double diffuseHorizontalRadiation;

  Hour copyWith({
    int? timeEpoch,
    String? time,
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
    double? snowCm,
    int? humidity,
    int? cloud,
    double? feelsLikeC,
    double? feelsLikeF,
    double? windChillC,
    double? windChillF,
    double? heatIndexC,
    double? heatIndexF,
    double? dewPointC,
    double? dewPointF,
    bool? willItRain,
    int? chanceOfRain,
    bool? willItSnow,
    int? chanceOfSnow,
    double? visibilityKilometers,
    double? visibilityMiles,
    double? gustMph,
    double? gustKph,
    double? uv,
    AirQuality? airQuality,
    double? shortwaveSolarRadiation,
    double? diffuseHorizontalRadiation,
  }) {
    return Hour(
      timeEpoch: timeEpoch ?? this.timeEpoch,
      time: time ?? this.time,
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
      snowCm: snowCm ?? this.snowCm,
      humidity: humidity ?? this.humidity,
      cloud: cloud ?? this.cloud,
      feelsLikeC: feelsLikeC ?? this.feelsLikeC,
      feelsLikeF: feelsLikeF ?? this.feelsLikeF,
      windChillC: windChillC ?? this.windChillC,
      windChillF: windChillF ?? this.windChillF,
      heatIndexC: heatIndexC ?? this.heatIndexC,
      heatIndexF: heatIndexF ?? this.heatIndexF,
      dewPointC: dewPointC ?? this.dewPointC,
      dewPointF: dewPointF ?? this.dewPointF,
      willItRain: willItRain ?? this.willItRain,
      chanceOfRain: chanceOfRain ?? this.chanceOfRain,
      willItSnow: willItSnow ?? this.willItSnow,
      chanceOfSnow: chanceOfSnow ?? this.chanceOfSnow,
      visibilityKilometers: visibilityKilometers ?? this.visibilityKilometers,
      visibilityMiles: visibilityMiles ?? this.visibilityMiles,
      gustMph: gustMph ?? this.gustMph,
      gustKph: gustKph ?? this.gustKph,
      uv: uv ?? this.uv,
      airQuality: airQuality ?? this.airQuality,
      shortwaveSolarRadiation:
          shortwaveSolarRadiation ?? this.shortwaveSolarRadiation,
      diffuseHorizontalRadiation:
          diffuseHorizontalRadiation ?? this.diffuseHorizontalRadiation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timeEpoch': timeEpoch,
      'time': time,
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
      'snowCm': snowCm,
      'humidity': humidity,
      'cloud': cloud,
      'feelsLikeC': feelsLikeC,
      'feelsLikeF': feelsLikeF,
      'windChillC': windChillC,
      'windChillF': windChillF,
      'heatIndexC': heatIndexC,
      'heatIndexF': heatIndexF,
      'dewPointC': dewPointC,
      'dewPointF': dewPointF,
      'willItRain': willItRain,
      'chanceOfRain': chanceOfRain,
      'willItSnow': willItSnow,
      'chanceOfSnow': chanceOfSnow,
      'visibilityKilometers': visibilityKilometers,
      'visibilityMiles': visibilityMiles,
      'gustMph': gustMph,
      'gustKph': gustKph,
      'uv': uv,
      'airQuality': airQuality.toMap(),
      'shortwaveSolarRadiation': shortwaveSolarRadiation,
      'diffuseHorizontalRadiation': diffuseHorizontalRadiation,
    };
  }

  factory Hour.fromMap(Map<String, dynamic> map) {
    return Hour(
      timeEpoch: map['time_epoch'] as int,
      time: map['time'] as String,
      tempC: map['temp_c'] as double,
      tempF: map['temp_f'] as double,
      itsDay: map['is_day'] as int,
      condition: Condition.fromMap(map['condition'] as Map<String, dynamic>),
      windMph: map['wind_mph'] as double,
      windKph: map['wind_kph'] as double,
      windDegree: map['wind_degree'] as int,
      windDir: map['wind_dir'] as String,
      pressureMb: map['pressure_mb'] as double,
      pressureIn: map['pressure_in'] as double,
      precipitationMm: map['precip_mm'] as double,
      precipitationIn: map['precip_in'] as double,
      snowCm: map['snow_cm'] as double,
      humidity: map['humidity'] as int,
      cloud: map['cloud'] as int,
      feelsLikeC: map['feelslike_c'] as double,
      feelsLikeF: map['feelslike_f'] as double,
      windChillC: map['windchill_c'] as double,
      windChillF: map['windchill_f'] as double,
      heatIndexC: map['heatindex_c'] as double,
      heatIndexF: map['heatindex_f'] as double,
      dewPointC: map['dewpoint_c'] as double,
      dewPointF: map['dewpoint_f'] as double,
      willItRain: map['will_it_rain'] == 1,
      chanceOfRain: map['chance_of_rain'] as int,
      willItSnow: map['will_it_snow'] == 1,
      chanceOfSnow: map['chance_of_snow'] as int,
      visibilityKilometers: map['vis_km'] as double,
      visibilityMiles: map['vis_miles'] as double,
      gustMph: map['gust_mph'] as double,
      gustKph: map['gust_kph'] as double,
      uv: map['uv'] as double,
      airQuality:
          AirQuality.fromMap(map['air_quality'] as Map<String, dynamic>),
      shortwaveSolarRadiation: map['short_rad'] as double,
      diffuseHorizontalRadiation: map['diff_rad'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Hour.fromJson(String source) =>
      Hour.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Hour(timeEpoch: $timeEpoch, time: $time, tempC: $tempC, tempF: $tempF, itsDay: $itsDay, condition: $condition, windMph: $windMph, windKph: $windKph, windDegree: $windDegree, windDir: $windDir, pressureMb: $pressureMb, pressureIn: $pressureIn, precipitationMm: $precipitationMm, precipitationIn: $precipitationIn, snowCm: $snowCm, humidity: $humidity, cloud: $cloud, feelsLikeC: $feelsLikeC, feelsLikeF: $feelsLikeF, windChillC: $windChillC, windChillF: $windChillF, heatIndexC: $heatIndexC, heatIndexF: $heatIndexF, dewPointC: $dewPointC, dewPointF: $dewPointF, willItRain: $willItRain, chanceOfRain: $chanceOfRain, willItSnow: $willItSnow, chanceOfSnow: $chanceOfSnow, visibilityKilometers: $visibilityKilometers, visibilityMiles: $visibilityMiles, gustMph: $gustMph, gustKph: $gustKph, uv: $uv, airQuality: $airQuality, shortwaveSolarRadiation: $shortwaveSolarRadiation, diffuseHorizontalRadiation: $diffuseHorizontalRadiation)';
  }

  @override
  bool operator ==(covariant Hour other) {
    if (identical(this, other)) return true;

    return other.timeEpoch == timeEpoch &&
        other.time == time &&
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
        other.snowCm == snowCm &&
        other.humidity == humidity &&
        other.cloud == cloud &&
        other.feelsLikeC == feelsLikeC &&
        other.feelsLikeF == feelsLikeF &&
        other.windChillC == windChillC &&
        other.windChillF == windChillF &&
        other.heatIndexC == heatIndexC &&
        other.heatIndexF == heatIndexF &&
        other.dewPointC == dewPointC &&
        other.dewPointF == dewPointF &&
        other.willItRain == willItRain &&
        other.chanceOfRain == chanceOfRain &&
        other.willItSnow == willItSnow &&
        other.chanceOfSnow == chanceOfSnow &&
        other.visibilityKilometers == visibilityKilometers &&
        other.visibilityMiles == visibilityMiles &&
        other.gustMph == gustMph &&
        other.gustKph == gustKph &&
        other.uv == uv &&
        other.airQuality == airQuality &&
        other.shortwaveSolarRadiation == shortwaveSolarRadiation &&
        other.diffuseHorizontalRadiation == diffuseHorizontalRadiation;
  }

  @override
  int get hashCode {
    return timeEpoch.hashCode ^
        time.hashCode ^
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
        snowCm.hashCode ^
        humidity.hashCode ^
        cloud.hashCode ^
        feelsLikeC.hashCode ^
        feelsLikeF.hashCode ^
        windChillC.hashCode ^
        windChillF.hashCode ^
        heatIndexC.hashCode ^
        heatIndexF.hashCode ^
        dewPointC.hashCode ^
        dewPointF.hashCode ^
        willItRain.hashCode ^
        chanceOfRain.hashCode ^
        willItSnow.hashCode ^
        chanceOfSnow.hashCode ^
        visibilityKilometers.hashCode ^
        visibilityMiles.hashCode ^
        gustMph.hashCode ^
        gustKph.hashCode ^
        uv.hashCode ^
        airQuality.hashCode ^
        shortwaveSolarRadiation.hashCode ^
        diffuseHorizontalRadiation.hashCode;
  }
}
