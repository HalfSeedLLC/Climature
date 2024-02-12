import 'package:flutter/material.dart';
import 'package:weather_app/theme/colors.dart';

import '../../../utils/utils.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    required this.city,
    required this.time,
    required this.forecast,
    required this.degrees,
    required this.iconAsset,
    this.onPressed,
    this.fontColor = WeatherColors.black,
    this.backgroundColor = WeatherColors.white,
    Key? key,
  }) : super(key: key);

  final String city;
  final String time;
  final String forecast;
  final String degrees;
  final String iconAsset;
  final void Function()? onPressed;
  final Color fontColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(15)),
        child: TextButton(
          onPressed: () => onPressed?.call(),
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (iconAsset.isNotEmpty)
                            SizedBox(
                              width: 55,
                              height: 55,
                              child: OverflowBox(
                                maxWidth: double.infinity,
                                maxHeight: double.infinity,
                                child: Image.asset(
                                    width: 20,
                                    height: 20,
                                    getWeatherIconAsset(iconAsset: iconAsset)),
                              ),
                            ),
                          const SizedBox(
                            width: 7,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                city,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: fontColor, height: 1),
                              ),
                              Text(
                                time,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          forecast,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: fontColor),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        degrees,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: fontColor, letterSpacing: 1),
                      ),
                      Text('°',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w100,
                                  color: fontColor))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
