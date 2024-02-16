import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class Sunrise extends StatelessWidget {
  const Sunrise({
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
                    Icon(Icons.wb_twilight_outlined,
                        color: WeatherColors.white),
                    Text('SUNRISE')
                  ],
                ),
                const SizedBox(height: 10),
                Text('7:03AM',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        height: 1.5,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: WeatherColors.white)),
                Text('Sunset: 5:27PM',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        height: 1.25,
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
