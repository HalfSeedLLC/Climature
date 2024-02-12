import 'package:flutter/material.dart';
import 'package:weather_app/pages/city_forecast/widgets/next_hour.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/forecast_cubit/forecast_cubit.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/pages/city_forecast/widgets/air_quality.dart';
import 'package:weather_app/pages/city_forecast/widgets/city_header.dart';
import 'package:weather_app/pages/city_forecast/widgets/forecast_hour_list/forecast_hour_list.dart';
import 'package:weather_app/pages/city_forecast/widgets/future_forecast.dart';

class CityForecast extends StatefulWidget {
  const CityForecast({
    Key? key,
  }) : super(key: key);

  static const route = '/city';
  static const name = 'City Forecast';

  @override
  State<CityForecast> createState() => _CityForecast();
}

class _CityForecast extends State<CityForecast>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ForecastCubit, ForecastState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: WeatherColors.black,
            body: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return SizeTransition(
                    axisAlignment: -1,
                    sizeFactor: _animationController,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _animationController.value * 1,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 350 * _animationController.value,
                            child: OverflowBox(
                              maxHeight: 350,
                              child: CityHeader(
                                title: state.forecast?.location.name ?? '',
                                condition:
                                    state.forecast?.current.condition.text ??
                                        '',
                                currentTemp:
                                    '${state.forecast?.current.tempF.toInt() ?? ''}',
                                tempHi:
                                    '${state.forecastDays?.first.day.maxTempF.toInt() ?? ''}',
                                tempLow:
                                    '${state.forecastDays?.first.day.minTempF.toInt() ?? ''}',
                                iconAsset:
                                    state.forecast?.current.condition.icon ??
                                        '',
                                airQualityMessage: getAirQualityMessage(
                                    usEpaIndex: state.forecast?.current
                                        .airQuality.usEpaIndex),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: Wrap(
                                  runSpacing: 15,
                                  children: [
                                    NextHour(
                                        condition: state.forecast?.current
                                                .condition.text ??
                                            '',
                                        iconAsset: state.forecast?.current
                                                .condition.icon ??
                                            ''),
                                    ForecastHourList(
                                        forecastHours:
                                            state.hourlyForecast ?? []),
                                    FutureForecast(
                                        forecastDays: state.forecastDays),
                                    const AirQuality()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        },
      );
}
