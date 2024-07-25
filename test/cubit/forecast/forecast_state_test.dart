import 'package:climature/pages/city_forecast/cubit/forecast_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/forecast.dart';

void main() {
  group('ForecastState', () {
    test('supports value comparisons', () {
      expect(
        const ForecastState(),
        const ForecastState(),
      );
    });

    test('has correct initial values', () {
      const state = ForecastState();
      expect(state.isLoading, true);
      expect(state.forecast, null);
      expect(state.forecastDays, null);
      expect(state.hourlyForecast, null);
    });

    test('copyWith returns new instance with updated values', () {
      final oldMockForecast = createMockForecast();
      final newMockForecast = createMockForecast();

      final state = ForecastState(
        isLoading: true,
        forecast: oldMockForecast,
        forecastDays: oldMockForecast.forecast['forecastday'],
        hourlyForecast: oldMockForecast.forecast['forecastday']
                ?.expand((day) => day.hours)
                .skip(DateTime.parse(oldMockForecast.current.lastUpdated).hour)
                .take(22)
                .toList() ??
            [],
      );

      final newState = state.copyWith(
        isLoading: false,
        forecast: newMockForecast,
        forecastDays: newMockForecast.forecast['forecastday'],
        hourlyForecast: newMockForecast.forecast['forecastday']
                ?.expand((day) => day.hours)
                .skip(DateTime.parse(newMockForecast.current.lastUpdated).hour)
                .take(22)
                .toList() ??
            [],
      );

      expect(newState.isLoading, false);
      expect(newState.forecast, newMockForecast);
      expect(newState.forecastDays, newMockForecast.forecast['forecastday']);
      expect(
          newState.hourlyForecast,
          newMockForecast.forecast['forecastday']
                  ?.expand((day) => day.hours)
                  .skip(DateTime.parse(newMockForecast.current.lastUpdated).hour)
                  .take(22)
                  .toList() ??
              []);
      expect(newState, isNot(state));
    });

    test('props are correct', () {
      final mockForecast = createMockForecast();

      final state = ForecastState(
        isLoading: true,
        forecast: mockForecast,
        forecastDays: mockForecast.forecast['forecastday'],
        hourlyForecast: mockForecast.forecast['forecastday']
                ?.expand((day) => day.hours)
                .skip(DateTime.parse(mockForecast.current.lastUpdated).hour)
                .take(22)
                .toList() ??
            [],
      );

      expect(state.isLoading, true);
      expect(state.forecast, mockForecast);
      expect(state.forecastDays, mockForecast.forecast['forecastday']);
      expect(
          state.hourlyForecast,
          mockForecast.forecast['forecastday']
                  ?.expand((day) => day.hours)
                  .skip(DateTime.parse(mockForecast.current.lastUpdated).hour)
                  .take(22)
                  .toList() ??
              []);
    });
  });
}
