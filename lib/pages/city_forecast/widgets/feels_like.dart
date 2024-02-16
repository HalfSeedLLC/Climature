import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class FeelsLike extends StatelessWidget {
  const FeelsLike({
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
                    Icon(Icons.device_thermostat, color: Color(0xFFA42516)),
                    Text('FEELS LIKE'),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('18',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            height: 1.5,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: WeatherColors.white)),
                    Text('°',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            height: 1,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: WeatherColors.white))
                  ],
                ),
                const Spacer(),
                Text('Humidity is making it feel warmer.',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        height: 1.5,
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        // letterSpacing:
                        //     1,
                        color: WeatherColors.secondaryFont))
              ],
            ),
          ),
        ),
      );
}
