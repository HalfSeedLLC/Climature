import 'dart:math';

import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class Wind extends StatelessWidget {
  const Wind({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
            color: WeatherColors.ev1, borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 7,
                  children: [
                    Icon(Icons.air, color: WeatherColors.white),
                    Text('WIND'),
                  ],
                ),
                Center(
                    child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    const Compass(),
                    Transform.rotate(
                      angle: pi / 4,
                      child: const SizedBox(
                        width: 155,
                        height: 155,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CompassTrianglePointer(),
                            SizedBox(height: 1)
                          ],
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      );
}

class Compass extends StatelessWidget {
  const Compass({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(155, 155),
      painter: CompassPainter(),
    );
  }
}

class CompassPainter extends CustomPainter {
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

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (double i = 0; i < 2 * pi; i += pi / 60) {
      final double x1 = centerX + radius * cos(i);
      final double y1 = centerY + radius * sin(i);
      double x2, y2;

      final index = i.toStringAsPrecision(3);

      // Initialize directionLabel with an empty string
      String directionLabel = '';

      // Check if the angle corresponds to 12, 3, 6, or 9 o'clock positions
      if (index == '0.00' ||
          index == '3.14' ||
          index == '1.57' ||
          index == '4.71') {
        // Draw longer lines at 12, 3, 6, and 9 o'clock positions with special color
        x2 = centerX + (radius - 12) * cos(i);
        y2 = centerY + (radius - 12) * sin(i);
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), specialPaint);

        // Determine the direction label based on the angle
        if (index == '0.00') {
          directionLabel = 'E';
        } else if (index == '3.14') {
          directionLabel = 'W';
        } else if (index == '1.57') {
          directionLabel = 'S';
        } else if (index == '4.71') {
          directionLabel = 'N';
        }

        // Draw text labels for N, S, E, W at the longer lines
        textPainter.text = TextSpan(
          text: directionLabel,
          style: const TextStyle(color: WeatherColors.white, fontSize: 16),
        );
        textPainter.layout();
        textPainter.paint(
            canvas,
            Offset(
                x2 -
                    textPainter.width / 2 -
                    (index == '0.00'
                        ? 15
                        : index == '3.14'
                            ? -15
                            : 0),
                y2 -
                    textPainter.height / 2 -
                    (index == '1.57'
                        ? 15
                        : index == '4.71'
                            ? -15
                            : 0)));
      } else {
        // Draw shorter lines for other positions with default color
        x2 = centerX + (radius - 10) * cos(i);
        y2 = centerY + (radius - 10) * sin(i);
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), defaultPaint);
      }
    }

    // Draw text in the center of the circle
    const String mainText = '9';
    const String subText = 'mph';
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

class CompassTrianglePointer extends StatelessWidget {
  const CompassTrianglePointer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: CustomPaint(
        size: const Size(15, 15),
        painter: CompassTrianglePointerPainter(),
      ),
    );
  }
}

class CompassTrianglePointerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint redPaint = Paint()..color = Colors.red;
    final Paint whitePaint = Paint()..color = Colors.white;

    final Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final Rect rect =
        Rect.fromPoints(Offset.zero, Offset(size.width, size.height / 1.5));

    final Path redPath =
        Path.combine(PathOperation.intersect, path, Path()..addRect(rect));
    final Path whitePath =
        Path.combine(PathOperation.difference, path, redPath);

    canvas.drawPath(redPath, redPaint);
    canvas.drawPath(whitePath, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
