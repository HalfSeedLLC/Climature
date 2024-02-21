import 'package:flutter/material.dart';
import 'package:weather_app/pages/city_forecast/widgets/feels_like.dart';
import 'package:weather_app/pages/city_forecast/widgets/sunrise.dart';
import 'package:weather_app/pages/city_forecast/widgets/humidity.dart';
import 'package:weather_app/pages/city_forecast/widgets/pressure.dart';
import 'package:weather_app/pages/city_forecast/widgets/rainfall.dart';
import 'package:weather_app/pages/city_forecast/widgets/uv_index.dart';
import 'package:weather_app/pages/city_forecast/widgets/next_hour.dart';
import 'package:weather_app/pages/city_forecast/widgets/weather_visibility.dart';
import 'package:weather_app/pages/city_forecast/widgets/wind.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/pages/city_forecast/widgets/city_header.dart';
import 'package:weather_app/pages/city_forecast/widgets/forecast_hour_list/forecast_hour_list.dart';
import 'package:weather_app/pages/city_forecast/widgets/future_forecast.dart';

import 'cubit/forecast_cubit.dart';
import 'widgets/air_quality.dart';

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
            body: LayoutBuilder(builder: (context, constraints) {
              return AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _animationController.value * 1,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: constraints.maxHeight - 340,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      Wrap(
                                        runSpacing: 15,
                                        children: [
                                          SizedBox(
                                            height: 95,
                                            width: double.infinity,
                                            child: Stack(
                                              children: [
                                                AnimatedPositioned(
                                                  left: 0,
                                                  right: 0,
                                                  top:
                                                      state.isLoading ? -75 : 0,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  child: AnimatedOpacity(
                                                    opacity:
                                                        state.isLoading ? 0 : 1,
                                                    duration: const Duration(
                                                        milliseconds: 1000),
                                                    child: NextHour(
                                                        isLoading:
                                                            state.isLoading,
                                                        condition: state
                                                                .forecast
                                                                ?.current
                                                                .condition
                                                                .text ??
                                                            '',
                                                        iconAsset: state
                                                                .forecast
                                                                ?.current
                                                                .condition
                                                                .icon ??
                                                            ''),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 170,
                                            child: Stack(
                                              children: [
                                                AnimatedPositioned(
                                                  left: 0,
                                                  right: 0,
                                                  top:
                                                      state.isLoading ? -75 : 0,
                                                  duration: const Duration(
                                                      milliseconds: 900),
                                                  child: AnimatedOpacity(
                                                    opacity:
                                                        state.isLoading ? 0 : 1,
                                                    duration: const Duration(
                                                        milliseconds: 1200),
                                                    child: ForecastHourList(
                                                        forecastHours: state
                                                                .hourlyForecast ??
                                                            []),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 345,
                                            child: Stack(
                                              children: [
                                                AnimatedPositioned(
                                                  left: 0,
                                                  right: 0,
                                                  top:
                                                      state.isLoading ? -75 : 0,
                                                  duration: const Duration(
                                                      milliseconds: 900),
                                                  child: AnimatedOpacity(
                                                    opacity:
                                                        state.isLoading ? 0 : 1,
                                                    duration: const Duration(
                                                        milliseconds: 1400),
                                                    child: FutureForecast(
                                                        forecastDays:
                                                            state.forecastDays),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          AirQualityCard(
                                            airQuality: state
                                                .forecast?.current.airQuality,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: UVIndex(
                                                uv: state.forecast?.current.uv,
                                              )),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Sunrise(
                                                  sunrise:
                                                      '${state.forecastDays?.first.astro.sunrise}',
                                                  sunset:
                                                      '${state.forecastDays?.first.astro.sunset}',
                                                  currentTime:
                                                      '${state.forecast?.location.localTime}',
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Wind(
                                                windSpeed: state.forecast
                                                        ?.current.windMph ??
                                                    0,
                                                windDegree: state.forecast
                                                        ?.current.windDegree ??
                                                    0,
                                              )),
                                              const SizedBox(width: 10),
                                              const Expanded(child: Rainfall()),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: FeelsLike(
                                                feelsLike: state.forecast
                                                        ?.current.feelsLikeF ??
                                                    0,
                                                currentTemp: state.forecast
                                                        ?.current.tempF ??
                                                    0,
                                              )),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                  child: Humidity(
                                                humidity: state.forecast
                                                        ?.current.humidity ??
                                                    0,
                                              )),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: WeatherVisibility(
                                                visibility: state
                                                        .forecast
                                                        ?.current
                                                        .visibilityMiles ??
                                                    0,
                                              )),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                  child: Pressure(
                                                pressure: state.forecast
                                                        ?.current.pressureIn ??
                                                    0,
                                              )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(40),
                            child: AnimatedSize(
                              alignment: Alignment.bottomCenter,
                              duration: const Duration(milliseconds: 750),
                              child: SizedBox(
                                height: 350 * _animationController.value,
                                child: OverflowBox(
                                  maxHeight: 350,
                                  child: CityHeader(
                                    isLoading: state.isLoading,
                                    title: state.forecast?.location.name ?? '',
                                    condition: state
                                            .forecast?.current.condition.text ??
                                        '',
                                    currentTemp:
                                        '${state.forecast?.current.tempF.toInt() ?? ''}',
                                    tempHi:
                                        '${state.forecastDays?.first.day.maxTempF.toInt() ?? ''}',
                                    tempLow:
                                        '${state.forecastDays?.first.day.minTempF.toInt() ?? ''}',
                                    iconAsset: state
                                            .forecast?.current.condition.icon ??
                                        '',
                                    airQualityMessage: getAirQualityMessage(
                                        usEpaIndex: state.forecast?.current
                                            .airQuality.usEpaIndex),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }),
          );
        },
      );
}
