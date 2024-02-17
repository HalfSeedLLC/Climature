import 'package:flutter/material.dart';

import '../../../models/air_quality.dart';
import '../../../theme/colors.dart';
import '../../../widgets/air_quality_line.dart';
import '../util/util.dart';

class AirQualityCard extends StatelessWidget {
  const AirQualityCard({
    this.airQuality,
    Key? key,
  }) : super(key: key);

  final AirQuality? airQuality;

  @override
  Widget build(BuildContext context) {
    final aqi = calculatePM25AQI(airQuality?.pm2_5 ?? 0);

    return DecoratedBox(
      decoration: BoxDecoration(
          color: WeatherColors.ev1, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(size: 24, Icons.air, color: Colors.lightBlue),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('AIR QUALITY (PM2.5)',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          height: 1,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          color: WeatherColors.secondaryFont)),
                ],
              ),
              const SizedBox(height: 25),
              Text('$aqi - ${getAQICategory(aqi)}',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      height: 1,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: WeatherColors.white)),
              const SizedBox(height: 10),
              Text('Air Quality index is $aqi. ${getAQIMessage(aqi)}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      height: 1.5,
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: WeatherColors.secondaryFont)),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: GradientLineWithMarker(
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
                  markerPosition: aqi / 500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
