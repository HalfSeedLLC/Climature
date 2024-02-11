import 'dart:convert';

class Astro {
  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
    required this.isMoonUp,
    required this.isSunUp,
  });

  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final int moonIllumination;
  final bool isMoonUp;
  final bool isSunUp;

  Astro copyWith({
    String? sunrise,
    String? sunset,
    String? moonrise,
    String? moonset,
    String? moonPhase,
    int? moonIllumination,
    bool? isMoonUp,
    bool? isSunUp,
  }) {
    return Astro(
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      moonrise: moonrise ?? this.moonrise,
      moonset: moonset ?? this.moonset,
      moonPhase: moonPhase ?? this.moonPhase,
      moonIllumination: moonIllumination ?? this.moonIllumination,
      isMoonUp: isMoonUp ?? this.isMoonUp,
      isSunUp: isSunUp ?? this.isSunUp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sunrise': sunrise,
      'sunset': sunset,
      'moonrise': moonrise,
      'moonset': moonset,
      'moonPhase': moonPhase,
      'moonIllumination': moonIllumination,
      'isMoonUp': isMoonUp,
      'isSunUp': isSunUp,
    };
  }

  factory Astro.fromMap(Map<String, dynamic> map) {
    return Astro(
      sunrise: map['sunrise'] as String,
      sunset: map['sunset'] as String,
      moonrise: map['moonrise'] as String,
      moonset: map['moonset'] as String,
      moonPhase: map['moon_phase'] as String,
      moonIllumination: map['moon_illumination'] as int,
      isMoonUp: map['is_moon_up'] == 1,
      isSunUp: map['is_sun_up'] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory Astro.fromJson(String source) =>
      Astro.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Astro(sunrise: $sunrise, sunset: $sunset, moonrise: $moonrise, moonset: $moonset, moonPhase: $moonPhase, moonIllumination: $moonIllumination, isMoonUp: $isMoonUp, isSunUp: $isSunUp)';
  }

  @override
  bool operator ==(covariant Astro other) {
    if (identical(this, other)) return true;

    return other.sunrise == sunrise &&
        other.sunset == sunset &&
        other.moonrise == moonrise &&
        other.moonset == moonset &&
        other.moonPhase == moonPhase &&
        other.moonIllumination == moonIllumination &&
        other.isMoonUp == isMoonUp &&
        other.isSunUp == isSunUp;
  }

  @override
  int get hashCode {
    return sunrise.hashCode ^
        sunset.hashCode ^
        moonrise.hashCode ^
        moonset.hashCode ^
        moonPhase.hashCode ^
        moonIllumination.hashCode ^
        isMoonUp.hashCode ^
        isSunUp.hashCode;
  }
}
