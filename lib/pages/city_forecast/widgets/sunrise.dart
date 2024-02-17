import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weather_app/pages/city_forecast/util/util.dart';
import '../../../theme/colors.dart';

class Sunrise extends StatelessWidget {
  const Sunrise({
    required this.sunrise,
    required this.sunset,
    required this.currentTime,
    Key? key,
  }) : super(key: key);

  final String sunrise;
  final String sunset;
  final String currentTime;

  @override
  Widget build(BuildContext context) {
    print(currentTime);
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
                  Icon(Icons.wb_twilight_outlined, color: WeatherColors.white),
                  Text('SUNRISE')
                ],
              ),
              const SizedBox(height: 10),
              Text(sunrise,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      height: 1.5,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: WeatherColors.white)),
              SunriseGraph(
                sunPosition: calculateSunPosition(currentTime),
              ),
              Text('Sunset: $sunset',
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
}

class SunriseGraph extends StatelessWidget {
  const SunriseGraph({
    required this.sunPosition,
    Key? key,
  }) : super(key: key);

  final double sunPosition;

  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(200, 80),
            painter: SunrisePainter(),
          ),
          const Divider(
            color: Colors.white,
          ),
          Positioned(
            left: sunPosition * 160,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 3, color: WeatherColors.white)),
            ),
          )
        ],
      );
}

class SunrisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();

    path.moveTo(0, size.height - 15);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..shader = LinearGradient(
        colors: [Colors.white.withOpacity(0.75), const Color(0xFF000000)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    const double amplitude = 25.0;
    final double wavelength = size.width / 2;

    for (double x = 0; x <= size.width; x++) {
      final double y = size.height / 2 + amplitude * cos(x / wavelength * pi);

      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}