import 'package:flutter/material.dart';
import 'package:weather_app/pages/city_forecast/util/util.dart';

import '../../../theme/colors.dart';

class WeatherVisibility extends StatelessWidget {
  const WeatherVisibility({
    required this.visibility,
    Key? key,
  }) : super(key: key);

  final double visibility;

  @override
  Widget build(BuildContext context) {
    final normalizedVisibility = visibility.toInt();

    return DecoratedBox(
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
                  Icon(Icons.waves, color: Color(0xFFAAAAAA)),
                  Text('VISIBILITY'),
                ],
              ),
              const SizedBox(height: 15),
              Text('$normalizedVisibility mi',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      height: 1.5,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: WeatherColors.white)),
              const Spacer(),
              Text(getWeatherDescription(normalizedVisibility),
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
}
