import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class Rainfall extends StatelessWidget {
  const Rainfall({
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
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 7,
                  children: [
                    const Icon(Icons.water_drop, color: Color(0xFFBEDBFB)),
                    Text('RAINFALL',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            height: 1.5,
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            // letterSpacing:
                            //     1,
                            color: WeatherColors.secondaryFont)),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('0"',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            height: 1.5,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: WeatherColors.white)),
                    Text('in last 24hr',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            height: 1,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: WeatherColors.white))
                  ],
                ),
                const Spacer(),
                Text('Next expected is .15" rain Thu.',
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
