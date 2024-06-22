import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';
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
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, constraints) {
        return DecoratedBox(
          decoration:
              BoxDecoration(color: WeatherColors.ev1, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                if (iconAsset.isNotEmpty)
                  isLoading
                      ? const GradientContainer(
                          height: 45,
                          width: 45,
                          borderRadius: 45,
                        )
                      : SizedBox(
                          width: 45,
                          height: 45,
                          child: OverflowBox(
                            maxWidth: double.infinity,
                            maxHeight: double.infinity,
                            child: Image.asset(
                              width: 55,
                              height: 55,
                              getWeatherIconAsset(iconAsset: iconAsset),
                            ),
                          ),
                        ),
                const SizedBox(width: 10), // Add some space between icon and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isLoading
                          ? const GradientContainer(height: 20, width: 120)
                          : Text(
                              condition,
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  height: 1,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: WeatherColors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                      const SizedBox(height: 5), // Add some space between texts
                      isLoading
                          ? const GradientContainer(height: 20, width: 200)
                          : TextScroll(
                              '$condition for the next hour',
                              mode: TextScrollMode.endless,
                              velocity: const Velocity(pixelsPerSecond: Offset(25, 0)),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(height: 1, fontSize: 16, color: WeatherColors.white),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
