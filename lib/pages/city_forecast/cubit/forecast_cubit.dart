import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/forecast_day.dart';
import 'package:weather_app/respository/weather_repository.dart';

import '../../../models/current.dart';
import '../../../models/forecast.dart';
import '../../../models/hour.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit({
    required this.city,
    required this.weatherRepository,
  }) : super(const ForecastState()) {
    init();
  }

  final String city;
  final WeatherRepository weatherRepository;

  void init() async {
    await getForecast(city: city);

    Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(isLoading: false));
  }

  Future<void> getForecast({required String city}) async {
    final forecast = await weatherRepository.getForecast(city: city);

    if (forecast != null) {
      getHourlyForecast(
          current: forecast.current,
          forecastDays: forecast.forecast.entries.first.value);

      emit(state.copyWith(
          forecast: forecast,
          forecastDays: forecast.forecast.entries.first.value));
    }
  }

  void getHourlyForecast(
      {required Current current, required List<ForecastDay> forecastDays}) {
    final currentHour = DateTime.parse(current.lastUpdated).hour;

    final List<Hour> hourlyForecast =
        forecastDays.expand((forecastDay) => forecastDay.hours).toList();

    final endIndex = currentHour + 22;

    final filteredHourlyForecast = hourlyForecast.sublist(
        currentHour, min(endIndex, hourlyForecast.length));

    emit(state.copyWith(hourlyForecast: filteredHourlyForecast));
  }
}
