import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../widgets/air_quality_line.dart';

class UVIndex extends StatelessWidget {
  const UVIndex({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
            color: WeatherColors.ev1, borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 7,
                  children: [
                    Icon(Icons.sunny, color: Color(0xFFE59D37)),
                    Text('UV INDEX')
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('0',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            height: 1.25,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: WeatherColors.white)),
                    Text('Low',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            height: 1,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: WeatherColors.white))
                  ],
                ),
                const Spacer(),
                Wrap(
                  runSpacing: 15,
                  children: [
                    const GradientLineWithMarker(
                      colors: [
                        Color.fromARGB(255, 25, 202, 1),
                        Color.fromARGB(255, 239, 225, 18),
                        Color(0xFFE8612A),
                        Color(0xFFE63226),
                        Color(0xFFE53288),
                        Color(0xFFA922F2),
                        Color(0xFF6B1216)
                      ],
                      height: 4,
                      borderRadius: 10,
                      markerPosition: .05,
                    ),
                    Text('Use sun protection 11AM - 3PM',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            height: 1.25,
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                            // letterSpacing:
                            //     1,
                            color: WeatherColors.secondaryFont))
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
