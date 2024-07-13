import 'dart:convert';

class AirQuality {
  AirQuality({
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.usEpaIndex,
    required this.gbDefraIndex,
  });

  final double? co;
  final double? no2;
  final double? o3;
  final double? so2;
  final double? pm2_5;
  final double? pm10;
  final int? usEpaIndex;
  final int? gbDefraIndex;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'co': co,
      'no2': no2,
      'o3': o3,
      'so2': so2,
      'pm2_5': pm2_5,
      'pm10': pm10,
      'usEpaIndex': usEpaIndex,
      'gbDefraIndex': gbDefraIndex,
    };
  }

  factory AirQuality.fromMap(Map<String, dynamic> map) {
    return AirQuality(
      co: map['co'] as double? ?? 0,
      no2: map['no2'] as double? ?? 0,
      o3: map['o3'] as double? ?? 0,
      so2: map['so2'] as double? ?? 0,
      pm2_5: map['pm2_5'] as double? ?? 0,
      pm10: map['pm10'] as double? ?? 0,
      usEpaIndex: map['us-epa-index'] as int? ?? 0,
      gbDefraIndex: map['gb-defra-index'] as int? ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AirQuality.fromJson(String source) =>
      AirQuality.fromMap(json.decode(source) as Map<String, dynamic>);

  AirQuality copyWith({
    double? co,
    double? no2,
    double? o3,
    double? so2,
    double? pm2_5,
    double? pm10,
    int? usEpaIndex,
    int? gbDefraIndex,
  }) {
    return AirQuality(
      co: co ?? this.co,
      no2: no2 ?? this.no2,
      o3: o3 ?? this.o3,
      so2: so2 ?? this.so2,
      pm2_5: pm2_5 ?? this.pm2_5,
      pm10: pm10 ?? this.pm10,
      usEpaIndex: usEpaIndex ?? this.usEpaIndex,
      gbDefraIndex: gbDefraIndex ?? this.gbDefraIndex,
    );
  }

  @override
  bool operator ==(covariant AirQuality other) {
    if (identical(this, other)) return true;

    return other.co == co &&
        other.no2 == no2 &&
        other.o3 == o3 &&
        other.so2 == so2 &&
        other.pm2_5 == pm2_5 &&
        other.pm10 == pm10 &&
        other.usEpaIndex == usEpaIndex &&
        other.gbDefraIndex == gbDefraIndex;
  }

  @override
  int get hashCode {
    return co.hashCode ^
        no2.hashCode ^
        o3.hashCode ^
        so2.hashCode ^
        pm2_5.hashCode ^
        pm10.hashCode ^
        usEpaIndex.hashCode ^
        gbDefraIndex.hashCode;
  }

  @override
  String toString() {
    return 'AirQuality(co: $co, no2: $no2, o3: $o3, so2: $so2, pm2_5: $pm2_5, pm10: $pm10, usEpaIndex: $usEpaIndex, gbDefraIndex: $gbDefraIndex)';
  }
}
