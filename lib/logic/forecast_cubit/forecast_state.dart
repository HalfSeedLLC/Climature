part of 'forecast_cubit.dart';

class ForecastState extends Equatable {
  const ForecastState({
    this.forecast,
    this.forecastDays,
  });

  final Forecast? forecast;
  final List<ForecastDay>? forecastDays;

  @override
  List<Object?> get props => [forecast, forecastDays];

  ForecastState copyWith({
    Forecast? forecast,
    List<ForecastDay>? forecastDays,
  }) {
    return ForecastState(
        forecast: forecast ?? this.forecast,
        forecastDays: forecastDays ?? this.forecastDays);
  }
}
