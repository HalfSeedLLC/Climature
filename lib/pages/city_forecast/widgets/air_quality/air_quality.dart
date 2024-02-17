import 'package:flutter/material.dart';

import '../../../../models/air_quality.dart';
import '../../../../theme/colors.dart';
import '../../../../widgets/air_quality_line.dart';

class AirQualityCard extends StatelessWidget {
  const AirQualityCard({
    this.airQuality,
    Key? key,
  }) : super(key: key);

  final AirQuality? airQuality;

  int calculatePM25AQI(double concentration) {
    final List<double> pm25ConcentrationRanges = [
      0.0,
      12.1,
      35.5,
      55.5,
      150.5,
      250.5,
      350.5
    ];
    final List<int> pm25AQIRanges = [0, 51, 101, 151, 201, 301, 401, 501];

    int index = 0;
    while (index < pm25ConcentrationRanges.length - 1 &&
        concentration > pm25ConcentrationRanges[index + 1]) {
      index++;
    }

    double lowerConcentration = pm25ConcentrationRanges[index];
    double upperConcentration = pm25ConcentrationRanges[index + 1];
    int lowerAQI = pm25AQIRanges[index];
    int upperAQI = pm25AQIRanges[index + 1];

    double aqi = ((upperAQI - lowerAQI) *
            (concentration - lowerConcentration) /
            (upperConcentration - lowerConcentration)) +
        lowerAQI;
    return aqi.toInt();
  }

  String getAQICategory(int aqiValue) {
    if (aqiValue >= 0 && aqiValue <= 50) {
      return "Good";
    } else if (aqiValue >= 51 && aqiValue <= 100) {
      return "Moderate";
    } else if (aqiValue >= 101 && aqiValue <= 150) {
      return "Unhealthy for Sensitive Groups";
    } else if (aqiValue >= 151 && aqiValue <= 200) {
      return "Unhealthy";
    } else if (aqiValue >= 201 && aqiValue <= 300) {
      return "Very Unhealthy";
    } else if (aqiValue >= 301) {
      return "Hazardous";
    } else {
      return "Invalid AQI value";
    }
  }

  String getAQIMessage(int aqiValue) {
    if (aqiValue >= 0 && aqiValue <= 50) {
      return "Air quality is good. It's a great day to be outside.";
    } else if (aqiValue >= 51 && aqiValue <= 100) {
      return "Air quality is acceptable. Consider making outdoor activities shorter and less intense.";
    } else if (aqiValue >= 101 && aqiValue <= 150) {
      return "Sensitive group: Make outdoor activities shorter and less intense. Take more breaks. Keep medicine handy.";
    } else if (aqiValue >= 151 && aqiValue <= 200) {
      return "Sensitive group: Avoid long or intense outdoor activities. Consider rescheduling or moving activities indoors. Reduce long or intense outdoor activities. Take more breaks.";
    } else if (aqiValue >= 201 && aqiValue <= 300) {
      return "Sensitive groups: Avoid all physical activity outdoors. Reschedule or move activities indoors. Avoid long or intense outdoor activities. Consider rescheduling or moving activities indoors.";
    } else if (aqiValue >= 301) {
      return "Everyone: Avoid all outdoor physical activities. Keep activity levels low at home.";
    } else {
      return "Invalid AQI value";
    }
  }

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
