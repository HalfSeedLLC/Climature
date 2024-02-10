import 'package:flutter/material.dart';
import 'package:weather_app/theme/colors.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    required this.city,
    required this.time,
    required this.forecast,
    required this.degrees,
    this.onPressed,
    this.fontColor = WeatherColors.black,
    this.backgroundColor = WeatherColors.white,
    Key? key,
  }) : super(key: key);

  final String city;
  final String time;
  final String forecast;
  final String degrees;
  final void Function()? onPressed;
  final Color fontColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => DecoratedBox(
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
                      children: [
                        Image.asset(
                            width: 60,
                            height: 60,
                            'assets/weather/icons/day/113.png'),
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
