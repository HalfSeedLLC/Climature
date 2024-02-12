part of 'forecast_cubit.dart';

class ForecastState extends Equatable {
  const ForecastState({
    this.forecast,
    this.forecastDays,
    this.hourlyForecast,
  });

  final Forecast? forecast;
  final List<ForecastDay>? forecastDays;
  final List<Hour>? hourlyForecast;

  @override
  List<Object?> get props => [forecast, forecastDays, hourlyForecast];

  ForecastState copyWith({
    Forecast? forecast,
    List<ForecastDay>? forecastDays,
    List<Hour>? hourlyForecast,
  }) {
    return ForecastState(
        forecast: forecast ?? this.forecast,
        forecastDays: forecastDays ?? this.forecastDays,
        hourlyForecast: hourlyForecast ?? this.hourlyForecast);
  }
}
