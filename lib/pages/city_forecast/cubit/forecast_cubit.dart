import 'dart:math';

import 'package:climature/models/forecast_day.dart';
import 'package:climature/respository/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  }

  Future<void> getForecast({required String city}) async {
    try {
      final forecast = await weatherRepository.getForecast(city: city);

      if (forecast != null) {
        getHourlyForecast(
            current: forecast.current, forecastDays: forecast.forecast.entries.first.value);

        emit(state.copyWith(
            forecast: forecast, forecastDays: forecast.forecast.entries.first.value));
      }
    } catch (e) {
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }

  void getHourlyForecast({required Current current, required List<ForecastDay> forecastDays}) {
    try {
      final currentHour = DateTime.parse(current.lastUpdated).hour;

      final List<Hour> hourlyForecast =
          forecastDays.expand((forecastDay) => forecastDay.hours).toList();

      final endIndex = currentHour + 22;

      final filteredHourlyForecast =
          hourlyForecast.sublist(currentHour, min(endIndex, hourlyForecast.length));

      emit(state.copyWith(isLoading: false, hourlyForecast: filteredHourlyForecast));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isError: true));
    }
  }
}
