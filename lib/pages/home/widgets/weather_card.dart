import 'package:flutter/material.dart';
import 'package:weather_app/theme/colors.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    required this.city,
    required this.time,
    required this.forecast,
    required this.degrees,
    this.fontColor = WeatherColors.black,
    this.backgroundColor = WeatherColors.white,
    Key? key,
  }) : super(key: key);

  final String city;
  final String time;
  final String forecast;
  final String degrees;
  final Color fontColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => DecoratedBox(
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(15)),
      child: TextButton(
        onPressed: () => print(''),
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
                      children: [
                        const Icon(
                            size: 30, Icons.sunny, color: Color(0xFFF19E39)),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              city,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: fontColor),
                            ),
                            Text(
                              time,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      forecast,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: fontColor),
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
