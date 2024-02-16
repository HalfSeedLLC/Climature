import 'package:flutter/material.dart';
import 'package:weather_app/widgets/gradient_container.dart';

import '../../../theme/colors.dart';
import '../../../utils/utils.dart';

class NextHour extends StatelessWidget {
  const NextHour({
    required this.iconAsset,
    required this.condition,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  final String iconAsset;
  final String condition;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
            color: WeatherColors.ev1, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 15),
                  if (iconAsset.isNotEmpty)
                    isLoading
                        ? const GradientContainer(
                            height: 45,
                            width: 45,
                            borderRadius: 45,
                          )
                        : SizedBox(
                            width: 20,
                            height: 45,
                            child: OverflowBox(
                              maxWidth: double.infinity,
                              maxHeight: double.infinity,
                              child: Image.asset(
                                  width: 55,
                                  height: 55,
                                  getWeatherIconAsset(iconAsset: iconAsset)),
                            ),
                          ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Wrap(
                      spacing: 5,
                      direction: Axis.vertical,
                      children: [
                        isLoading
                            ? const GradientContainer(height: 20, width: 120)
                            : Text(condition,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        height: 1,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: WeatherColors.white)),
                        isLoading
                            ? const GradientContainer(height: 20, width: 200)
                            : Text('$condition for the next hour')
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
}
