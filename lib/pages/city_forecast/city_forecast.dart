import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/pages/city_forecast/utils/utils.dart';
import 'package:weather_app/pages/city_forecast/widgets/air_quality_line.dart';
import 'package:weather_app/pages/city_forecast/widgets/city_header.dart';
import 'package:weather_app/pages/city_forecast/widgets/forecast_hour.dart';
import 'package:weather_app/pages/city_forecast/widgets/temperature_trend.dart';
import 'package:weather_app/theme/colors.dart';

import '../../logic/forecast_cubit/forecast_cubit.dart';

class CityForecast extends StatefulWidget {
  const CityForecast({
    Key? key,
  }) : super(key: key);

  static const route = '/city';

  @override
  State<CityForecast> createState() => _CityForecast();
}

class _CityForecast extends State<CityForecast>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<String> forecastDays = getDayOfWeekStrings();

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
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 25),
                                child: Wrap(
                                  runSpacing: 15,
                                  children: [
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: WeatherColors.ev1,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(25),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                    width: 50,
                                                    height: 50,
                                                    'assets/weather/icons/day/113.png'),
                                                const SizedBox(width: 5),
                                                Wrap(
                                                  spacing: 5,
                                                  direction: Axis.vertical,
                                                  children: [
                                                    Text('Clear Conditions',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelLarge!
                                                            .copyWith(
                                                                height: 1,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    WeatherColors
                                                                        .white)),
                                                    const Text(
                                                        'Sunny Skies for the next hour')
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: WeatherColors.ev1,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: SizedBox(
                                        height: 170,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                        size: 24,
                                                        Icons.schedule,
                                                        color: WeatherColors
                                                            .secondaryFont),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text('HOURLY FORECAST',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                height: 1,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                letterSpacing:
                                                                    1,
                                                                color: WeatherColors
                                                                    .secondaryFont)),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20),
                                                  child: Wrap(
                                                    spacing: 30,
                                                    children: List.generate(
                                                        13,
                                                        (i) => ForecastHour(
                                                            time: i == 0
                                                                ? 'Now'
                                                                : '${i + 1}${i.isEven ? 'AM' : 'PM'} ',
                                                            temperature:
                                                                '${Random().nextInt(60) + 50}')),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: WeatherColors.ev1,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(25),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                      size: 24,
                                                      Icons.calendar_month,
                                                      color: WeatherColors
                                                          .secondaryFont),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('3-DAY-FORECAST',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              height: 1,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              letterSpacing: 1,
                                                              color: WeatherColors
                                                                  .secondaryFont)),
                                                ],
                                              ),
                                              const SizedBox(height: 30),
                                              Wrap(
                                                  runSpacing: 30,
                                                  children: List.generate(
                                                      3,
                                                      (i) => Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  forecastDays
                                                                      .elementAt(
                                                                          i),
                                                                  style: Theme
                                                                          .of(
                                                                              context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .copyWith(
                                                                          height:
                                                                              1,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight: FontWeight
                                                                              .w900,
                                                                          letterSpacing:
                                                                              0,
                                                                          color:
                                                                              WeatherColors.white)),
                                                              Wrap(
                                                                spacing: 15,
                                                                crossAxisAlignment:
                                                                    WrapCrossAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    '17°',
                                                                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                        fontSize:
                                                                            16,
                                                                        letterSpacing:
                                                                            1,
                                                                        color: WeatherColors
                                                                            .secondaryFont),
                                                                  ),
                                                                  Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            4,
                                                                        width:
                                                                            100,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                const Color(0xFF313131),
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            50,
                                                                        child:
                                                                            TemperatureRangeLine(
                                                                          lowTemperature:
                                                                              17,
                                                                          highTemperature:
                                                                              25,
                                                                          gradientColors: [
                                                                            Color(0xFFF3AD3C),
                                                                            Colors.red
                                                                          ], // Gradient colors
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    '25°',
                                                                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                        fontSize:
                                                                            16,
                                                                        letterSpacing:
                                                                            1,
                                                                        color: WeatherColors
                                                                            .white),
                                                                  ),
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 5,
                                                                        bottom:
                                                                            5),
                                                                    child: Icon(
                                                                        Icons
                                                                            .cloud,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: WeatherColors.ev1,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(25),
                                        child: SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                      size: 24,
                                                      Icons.air,
                                                      color: Colors.lightBlue),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('AIR QUALITY',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              height: 1,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              letterSpacing: 1,
                                                              color: WeatherColors
                                                                  .secondaryFont)),
                                                ],
                                              ),
                                              const SizedBox(height: 25),
                                              Text('73 - Moderate',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge!
                                                      .copyWith(
                                                          height: 1,
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: WeatherColors
                                                              .white)),
                                              const SizedBox(height: 10),
                                              Text(
                                                  'Air Quality index is 73, which is similar to yesterday at about this time',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          height: 1.5,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          letterSpacing: 1,
                                                          color: WeatherColors
                                                              .secondaryFont)),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 30, bottom: 10),
                                                child: GradientLineWithMarker(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 25, 202, 1),
                                                    Color.fromARGB(
                                                        255, 239, 225, 18),
                                                    Color(0xFFE8612A),
                                                    Color(0xFFE63226),
                                                    Color(0xFFE53288),
                                                    Color(0xFFA922F2),
                                                    Color(0xFF6B1216)
                                                  ],
                                                  height: 4,
                                                  borderRadius: 10,
                                                  markerPosition: .80,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
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
