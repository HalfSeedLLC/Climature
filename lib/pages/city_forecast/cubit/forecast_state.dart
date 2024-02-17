part of 'forecast_cubit.dart';

class ForecastState extends Equatable {
  const ForecastState({
    this.forecast,
    this.forecastDays,
    this.hourlyForecast,
    this.isLoading = true,
  });

  final Forecast? forecast;
  final List<ForecastDay>? forecastDays;
  final List<Hour>? hourlyForecast;
  final bool isLoading;

  @override
  List<Object?> get props =>
      [forecast, forecastDays, hourlyForecast, isLoading];

  ForecastState copyWith({
    Forecast? forecast,
    List<ForecastDay>? forecastDays,
    List<Hour>? hourlyForecast,
    bool? isLoading,
  }) {
    return ForecastState(
        forecast: forecast ?? this.forecast,
        forecastDays: forecastDays ?? this.forecastDays,
        hourlyForecast: hourlyForecast ?? this.hourlyForecast,
        isLoading: isLoading ?? this.isLoading);
  }
}
