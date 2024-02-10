import 'dart:convert';

class Location {
  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.localTimeEpoch,
    required this.localTime,
  });

  final String name;
  final String region;
  final String country;
  final double latitude;
  final double longitude;
  final String timezone;
  final int localTimeEpoch;
  final String localTime;

  Location copyWith({
    String? name,
    String? region,
    String? country,
    double? latitude,
    double? longitude,
    String? timezone,
    int? localTimeEpoch,
    String? localTime,
  }) {
    return Location(
      name: name ?? this.name,
      region: region ?? this.region,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timezone: timezone ?? this.timezone,
      localTimeEpoch: localTimeEpoch ?? this.localTimeEpoch,
      localTime: localTime ?? this.localTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'region': region,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
      'localTimeEpoch': localTimeEpoch,
      'localTime': localTime,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'] as String,
      region: map['region'] as String,
      country: map['country'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      timezone: map['timezone'] as String,
      localTimeEpoch: map['localTimeEpoch'] as int,
      localTime: map['localTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Location(name: $name, region: $region, country: $country, latitude: $latitude, longitude: $longitude, timezone: $timezone, localTimeEpoch: $localTimeEpoch, localTime: $localTime)';
  }

  @override
  bool operator ==(covariant Location other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.region == region &&
        other.country == country &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.timezone == timezone &&
        other.localTimeEpoch == localTimeEpoch &&
        other.localTime == localTime;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        region.hashCode ^
        country.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        timezone.hashCode ^
        localTimeEpoch.hashCode ^
        localTime.hashCode;
  }
}
