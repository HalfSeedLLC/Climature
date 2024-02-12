import 'package:weather_app/provider/weather_provider.dart';

import '../models/city.dart';
import '../models/forecast.dart';
import '../models/weather_card_data.dart';

class WeatherRepository {
  final _provider = WeatherProvider();

  Future<Forecast?> getForecast({
    required String city,
  }) async {
    return _provider.getForecast(city: city);
  }

  Future<List<City>> searchCities({
    required String city,
  }) async {
    return _provider.searchCities(city: city);
  }

  Future<WeatherCardData?> getLocationMetaData({
    required String city,
  }) async {
    return _provider.getLocationMetaData(city: city);
  }
}
