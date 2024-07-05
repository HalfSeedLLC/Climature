import 'package:climature/models/forecast_day.dart';
import 'package:climature/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../widgets/temperature_trend.dart';

class FutureForecast extends StatelessWidget {
  const FutureForecast({required this.forecastDays, Key? key}) : super(key: key);

  final List<ForecastDay>? forecastDays;

  @override
  Widget build(BuildContext context) {
    return forecastDays != null
        ? DecoratedBox(
            decoration:
                BoxDecoration(color: WeatherColors.ev1, borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                            size: 24, Icons.calendar_month, color: WeatherColors.secondaryFont),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('${forecastDays?.length ?? 0}-DAY-FORECAST',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                height: 1,
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                                color: WeatherColors.secondaryFont)),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Wrap(
                        runSpacing: 30,
                        children: List.generate(
                            forecastDays?.length ?? 0,
                            (i) => Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(getDayOfWeekString(date: forecastDays!.elementAt(i).date),
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            height: 1,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 0,
                                            color: WeatherColors.white)),
                                    Wrap(
                                      spacing: 15,
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: [
                                        Text(
                                          '${forecastDays!.elementAt(i).day.minTempF.toStringAsFixed(0)}°',
                                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 16,
                                              letterSpacing: 1,
                                              color: WeatherColors.secondaryFont),
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: 4,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFF313131),
                                                  borderRadius: BorderRadius.circular(10)),
                                            ),
                                            const SizedBox(
                                              width: 50,
                                              child: TemperatureRangeLine(
                                                lowTemperature: 17,
                                                highTemperature: 25,
                                                gradientColors: [
                                                  Color(0xFFF3AD3C),
                                                  Colors.red
                                                ], // Gradient colors
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${forecastDays!.elementAt(i).day.maxTempF.toStringAsFixed(0)}°',
                                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 16,
                                              letterSpacing: 1,
                                              color: WeatherColors.white),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                                          child: SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: OverflowBox(
                                              maxWidth: double.infinity,
                                              maxHeight: double.infinity,
                                              child: Image.asset(
                                                  width: 35,
                                                  height: 35,
                                                  getWeatherIconAsset(
                                                      iconAsset: forecastDays!
                                                          .elementAt(i)
                                                          .day
                                                          .condition
                                                          .icon)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )))
                  ],
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
