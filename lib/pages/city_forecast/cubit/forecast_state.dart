part of 'forecast_cubit.dart';

class ForecastState extends Equatable {
  const ForecastState({
    this.forecast,
    this.forecastDays,
    this.hourlyForecast,
    this.isError = false,
    this.isLoading = true,
  });

  final Forecast? forecast;
  final List<ForecastDay>? forecastDays;
  final List<Hour>? hourlyForecast;
  final bool isError;
  final bool isLoading;

  @override
  List<Object?> get props => [forecast, forecastDays, hourlyForecast, isError];

  ForecastState copyWith({
    Forecast? forecast,
    List<ForecastDay>? forecastDays,
    List<Hour>? hourlyForecast,
    bool? isError,
    bool? isLoading,
  }) {
    return ForecastState(
        forecast: forecast ?? this.forecast,
        forecastDays: forecastDays ?? this.forecastDays,
        hourlyForecast: hourlyForecast ?? this.hourlyForecast,
        isError: isError ?? this.isError,
        isLoading: isLoading ?? this.isLoading);
  }
}
