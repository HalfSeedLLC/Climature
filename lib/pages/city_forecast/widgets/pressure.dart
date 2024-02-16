import 'dart:math';

import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class Pressure extends StatelessWidget {
  const Pressure({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
            color: WeatherColors.ev1, borderRadius: BorderRadius.circular(20)),
        child: const SizedBox(
          height: 200,
          child: Padding(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 7,
                  children: [
                    Icon(Icons.cloud_sync_outlined, color: Colors.lightBlue),
                    Text('PRESSURE')
                  ],
                ),
                Center(child: PressureGauge())
              ],
            ),
          ),
        ),
      );
}

class PressureGauge extends StatelessWidget {
  const PressureGauge({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(155, 155),
      painter: PressureGaugePainter(),
    );
  }
}

class PressureGaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = min(centerX, centerY) - 5;

    final Paint defaultPaint = Paint()
      ..color = const Color(0xFF2B2B2B)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final Paint specialPaint = Paint()
      ..color = WeatherColors.white // Change color as needed
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.square;

    for (double i = 0; i < 2 * pi; i += pi / 60) {
      final double x1 = centerX + radius * cos(i);
      final double y1 = centerY + radius * sin(i);
      double x2, y2;

      final index = i.toStringAsPrecision(3);

      // Check if the angle corresponds to 12, 3, 6, or 9 o'clock positions
      if (index == '4.50') {
        // Draw longer lines at 12, 3, 6, and 9 o'clock positions with special color
        x2 = centerX + (radius - 12) * cos(i);
        y2 = centerY + (radius - 12) * sin(i);
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), specialPaint);
      }
      // Draw shorter lines for other positions with default color
      if (i > 2.4 || i < .74) {
        x2 = centerX + (radius - 10) * cos(i);
        y2 = centerY + (radius - 10) * sin(i);
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), defaultPaint);
      }
    }

    // Draw text in the center of the circle
    const String mainText = '30.07';
    const String subText = 'inHg';
    const TextStyle mainTextStyle = TextStyle(
        color: WeatherColors.white, fontSize: 25, fontWeight: FontWeight.w600);
    const TextStyle subTextStyle = TextStyle(
        color: WeatherColors.white,
        fontSize: 12,
        fontWeight: FontWeight.normal);

    const mainTextSpan = TextSpan(text: mainText, style: mainTextStyle);
    const subTextSpan = TextSpan(text: subText, style: subTextStyle);

    final mainTextPainter = TextPainter(
      text: mainTextSpan,
      textDirection: TextDirection.ltr,
    );

    final subTextPainter = TextPainter(
      text: subTextSpan,
      textDirection: TextDirection.ltr,
    );

    mainTextPainter.layout();
    subTextPainter.layout();

    final mainTextWidth = mainTextPainter.width;
    final mainTextHeight = mainTextPainter.height;
    final subTextWidth = subTextPainter.width;
    final subTextHeight = subTextPainter.height;

    final totalHeight = mainTextHeight + subTextHeight;

    mainTextPainter.paint(
      canvas,
      Offset(centerX - mainTextWidth / 2, centerY - totalHeight / 2),
    );

    subTextPainter.paint(
      canvas,
      Offset(centerX - subTextWidth / 2,
          centerY - totalHeight / 2 + mainTextHeight),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
