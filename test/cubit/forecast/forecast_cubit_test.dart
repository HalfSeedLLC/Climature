import 'package:bloc_test/bloc_test.dart';
import 'package:climature/pages/city_forecast/cubit/forecast_cubit.dart';
import 'package:climature/respository/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/forecast.dart';

class MockForecastCubit extends Mock implements ForecastCubit {}

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late ForecastCubit forecastCubit;
  late MockWeatherRepository mockWeatherRepository;
  final mockForecast = createMockForecast();

  setUpAll(() {
    registerFallbackValue(const ForecastState());
  });

  mockWeatherRepository = MockWeatherRepository();
  forecastCubit = ForecastCubit(city: 'San Francisco', weatherRepository: mockWeatherRepository);

  test('Initial State', () {
    expect(forecastCubit.state, const ForecastState(isError: true));
  });

  group('ForecastCubit', () {
    blocTest<ForecastCubit, ForecastState>(
      'Emits a new state getting forecast',
      setUp: () async {
        when(() => mockWeatherRepository.getForecast(city: any(named: 'city')))
            .thenAnswer((_) async => mockForecast);
      },
      build: () => forecastCubit,
      act: (cubit) => cubit.getForecast(city: 'San Francisco'),
      expect: () => [
        isA<ForecastState>()
            .having(
              (s) => s.isLoading,
              'isLoading',
              false,
            )
            .having(
              (s) => s.forecast,
              'forecast',
              mockForecast,
            )
            .having(
              (s) => s.forecastDays,
              'forecastDays',
              mockForecast.forecast['forecastday'],
            )
      ],
    );
  });
}
