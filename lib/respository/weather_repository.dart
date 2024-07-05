import 'package:climature/provider/weather_provider.dart';

import '../database/database.dart';
import '../models/city.dart';
import '../models/forecast.dart';
import '../models/weather_card_data.dart';

class WeatherRepository {
  WeatherRepository() {
    _initialize();
  }

  final _provider = WeatherProvider();
  late final ClimatureDatabase database;

  Future<void> _initialize() async {
    database = await ClimatureDatabase.create();
  }

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
