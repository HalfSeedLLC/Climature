import 'package:flutter/material.dart';
import 'package:weather_app/widgets/gradient_container.dart';

import '../../../../theme/colors.dart';

class WeatherCardSkeleton extends StatelessWidget {
  const WeatherCardSkeleton({
    this.backgroundColor = WeatherColors.ev1,
    Key? key,
  }) : super(key: key);

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return DecoratedBox(
        decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.65),
            borderRadius: BorderRadius.circular(15)),
        child: SizedBox(
          height: 100,
          width: double.infinity,
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
                          const GradientContainer(
                            width: 50,
                            height: 50,
                            borderRadius: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GradientContainer(
                                height: 10,
                                width: constraints.maxWidth / 4,
                              ),
                              const SizedBox(height: 15),
                              GradientContainer(
                                height: 10,
                                width: constraints.maxWidth / 4,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      GradientContainer(
                          width: constraints.maxWidth / 2, height: 10),
                    ]),
                const GradientContainer(
                  width: 50,
                  height: 50,
                  borderRadius: 70,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
