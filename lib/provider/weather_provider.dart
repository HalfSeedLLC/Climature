import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/forecast.dart';

class WeatherProvider {
  final client = http.Client();

  Future<Forecast?> getForecast({
    required String city,
  }) async {
    final uri = Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=${dotenv.env["WEATHER_API_KEY"]!}&q=$city&days=3&aqi=yes');
    final response = await client.get(uri);
    final Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      return Forecast.fromJson(const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}
