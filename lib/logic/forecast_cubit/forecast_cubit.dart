import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/forecast_day.dart';
import 'package:weather_app/respository/weather_repository.dart';

import '../../models/forecast.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit({
    required this.weatherRepository,
  }) : super(const ForecastState()) {
    init();
  }

  final WeatherRepository weatherRepository;

  void init() async {
    getForecast(city: 'Fresno');
  }

  void getForecast({required String city}) async {
    final forecast = await weatherRepository.getForecast(city: city);

    emit(state.copyWith(
        forecast: forecast,
        forecastDays: forecast?.forecast.entries.first.value));
  }
}
