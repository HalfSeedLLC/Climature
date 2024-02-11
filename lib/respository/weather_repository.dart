import 'package:weather_app/provider/weather_provider.dart';

import '../models/forecast.dart';

class WeatherRepository {
  final _provider = WeatherProvider();

  Future<Forecast?> getForecast({
    required String city,
  }) async {
    return _provider.getForecast(city: city);
  }
}
