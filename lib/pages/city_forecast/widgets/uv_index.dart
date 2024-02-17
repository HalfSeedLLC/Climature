import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../widgets/air_quality_line.dart';

class UVIndex extends StatelessWidget {
  const UVIndex({
    this.uv,
    Key? key,
  }) : super(key: key);

  final double? uv;

  String getUVMessage({required double uv}) {
    if (uv <= 3) {
      return 'You can safely enjoy being outside';
    } else if (uv <= 5) {
      return 'Take precaution during midday hours';
    } else if (uv <= 7) {
      return 'Protection against sun damage needed';
    } else if (uv <= 10) {
      return 'Reduce sun exposure 10AM - 4PM';
    }
    return 'Reduce sun exposure 10AM - 4PM';
  }

  @override
  Widget build(BuildContext context) {
    final double value = uv != null ? uv! : 0;

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
                  Text('$uv',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          height: 1.25,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: WeatherColors.white)),
                  Text(
                      value <= 2
                          ? 'Low'
                          : value >= 3 && value <= 5
                              ? 'Moderate'
                              : value >= 6 && value <= 7
                                  ? 'High'
                                  : value >= 8 && value <= 10
                                      ? 'Very High'
                                      : 'Extreme',
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
                  GradientLineWithMarker(
                    colors: const [
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
                    markerPosition: (value) / 11,
                  ),
                  SizedBox(
                    height: 48,
                    child: Text(getUVMessage(uv: value),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            height: 1.5,
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            color: WeatherColors.secondaryFont)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
