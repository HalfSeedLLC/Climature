import 'package:climature/models/city.dart';
import 'package:climature/models/forecast.dart';
import 'package:climature/models/weather_card_data.dart';
import 'package:climature/respository/weather_repository.dart';

import 'forecast.dart';

class MockWeatherRepository extends WeatherRepository {
  @override
  Future<Forecast?> getForecast({required String city}) async {
    if (city == 'San Francisco') {
      return createMockForecast();
    } else {
      return null;
    }
  }

  @override
  Future<List<City>> searchCities({required String city}) async {
    return [];
  }

  @override
  Future<WeatherCardData?> getLocationMetaData({required String city}) async {
    return null;
  }
}
