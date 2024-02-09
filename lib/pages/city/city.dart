import 'package:flutter/material.dart';
import 'package:weather_app/pages/city/widgets/city_header.dart';
import 'package:weather_app/theme/colors.dart';

class City extends StatefulWidget {
  const City({
    Key? key,
  }) : super(key: key);

  static const route = '/city';

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 350 * _animationController.value,
                          child: const OverflowBox(
                              maxHeight: 350, child: CityHeader()),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 25),
                          child: Wrap(
                            runSpacing: 15,
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                    color: WeatherColors.ev1,
                                    borderRadius: BorderRadius.circular(20)),
                                child: SizedBox(
                                  height: 170,
                                  width: double.infinity,
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
                                            const Icon(
                                                size: 40,
                                                Icons.sunny,
                                                color: Color(0xFFE5A24E)),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Wrap(
                                              spacing: 10,
                                              direction: Axis.vertical,
                                              children: [
                                                Text('Clear Conditions',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            height: 1,
                                                            fontSize: 20,
                                                            color: WeatherColors
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
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                    color: WeatherColors.ev1,
                                    borderRadius: BorderRadius.circular(20)),
                                child: SizedBox(
                                  height: 170,
                                  width: double.infinity,
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
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 0,
                                                        color: WeatherColors
                                                            .secondaryFont)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                    color: WeatherColors.ev1,
                                    borderRadius: BorderRadius.circular(20)),
                                child: SizedBox(
                                  height: 200,
                                  width: double.infinity,
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
                                            const Icon(
                                                size: 24,
                                                Icons.calendar_month,
                                                color: WeatherColors
                                                    .secondaryFont),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text('10-DAY-FORECAST',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        height: 1,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 0,
                                                        color: WeatherColors
                                                            .secondaryFont)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
}
