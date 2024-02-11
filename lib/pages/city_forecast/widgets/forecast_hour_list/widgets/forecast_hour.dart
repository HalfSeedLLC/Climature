import 'package:flutter/material.dart';

class ForecastHour extends StatelessWidget {
  const ForecastHour({
    required this.time,
    required this.temperature,
    this.iconAssetPath = 'assets/weather/icons/day/293.png',
    Key? key,
  }) : super(key: key);

  final String time;
  final String temperature;
  final String iconAssetPath;

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 5,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        children: [
          Text(
            time,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 15, letterSpacing: 0),
          ),
          if (iconAssetPath.isNotEmpty)
            SizedBox(
                height: 35,
                child: Image.asset(width: 35, height: 35, iconAssetPath)),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
              '$temperature°',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
        ],
      );
}
