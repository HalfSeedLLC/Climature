import 'package:flutter/material.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/pages/city_forecast/widgets/forecast_hour_list/widgets/forecast_hour.dart';

import '../../../../models/hour.dart';
import '../../../../theme/colors.dart';

class ForecastHourList extends StatelessWidget {
  const ForecastHourList({
    required this.forecastHours,
    Key? key,
  }) : super(key: key);

  final List<Hour> forecastHours;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
            color: WeatherColors.ev1, borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          height: 170,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                          size: 24,
                          Icons.schedule,
                          color: WeatherColors.secondaryFont),
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
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                  color: WeatherColors.secondaryFont)),
                    ],
                  ),
                ),
                const Spacer(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      spacing: 30,
                      children: List.generate(
                          forecastHours.length,
                          (i) => ForecastHour(
                                time: i == 0
                                    ? 'Now'
                                    : '${getUserFriendlyHour(dateTime: forecastHours.elementAt(i).time)} ',
                                temperature: forecastHours
                                    .elementAt(i)
                                    .tempF
                                    .toStringAsFixed(0),
                                iconAssetPath: getWeatherIconAsset(
                                    iconAsset: forecastHours
                                        .elementAt(i)
                                        .condition
                                        .icon),
                              )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}