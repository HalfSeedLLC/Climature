import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/weather_card_data.dart';

import '../models/city.dart';

class WeatherProvider {
  final _client = http.Client();

  Uri _buildUri({required String api, required String querySuffix}) {
    return Uri.parse(
        'http://api.weatherapi.com/v1/$api.json?key=${dotenv.env["WEATHER_API_KEY"]!}$querySuffix');
  }

  Future<Forecast?> getForecast({
    required String city,
  }) async {
    final uri = _buildUri(api: 'forecast', querySuffix: '&q=$city&days=5&aqi=yes');

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      return Forecast.fromJson(const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }

  Future<List<City>> searchCities({
    required String city,
  }) async {
    final uri = _buildUri(api: 'search', querySuffix: '&q=$city');

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<City> cities = data.map((cityJson) => City.fromJson(cityJson)).toList();
      return cities;
    } else {
      return [];
    }
  }

  Future<WeatherCardData?> getLocationMetaData({
    required String city,
  }) async {
    final uri = _buildUri(api: 'current', querySuffix: '&q=$city&aqi=yes');

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      return WeatherCardData.fromJson(const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}
