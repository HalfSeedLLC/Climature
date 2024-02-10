import 'package:flutter/material.dart';

class TemperatureRangeLine extends StatelessWidget {
  final double lowTemperature;
  final double highTemperature;
  final List<Color> gradientColors;

  const TemperatureRangeLine({
    super.key,
    required this.lowTemperature,
    required this.highTemperature,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: double.infinity,
      child: CustomPaint(
        painter: _TemperatureRangeLinePainter(
          lowTemperature: lowTemperature,
          highTemperature: highTemperature,
          gradientColors: gradientColors,
        ),
      ),
    );
  }
}

class _TemperatureRangeLinePainter extends CustomPainter {
  final double lowTemperature;
  final double highTemperature;
  final List<Color> gradientColors;

  _TemperatureRangeLinePainter({
    required this.lowTemperature,
    required this.highTemperature,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double lineWidth = size.width;
    final double lineCenterY = size.height / 2;

    final double lowTemperaturePosition = lineWidth * lowTemperature / 100;
    final double highTemperaturePosition = lineWidth * highTemperature / 100;

    final gradient = LinearGradient(
      colors: gradientColors,
    ).createShader(Rect.fromLTWH(0.0, 0.0, lineWidth, size.height));

    final Paint paint = Paint()
      ..shader = gradient
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    canvas.drawLine(
      Offset(0, lineCenterY),
      Offset(lowTemperaturePosition, lineCenterY),
      paint,
    );

    canvas.drawLine(
      Offset(lowTemperaturePosition, lineCenterY),
      Offset(highTemperaturePosition, lineCenterY),
      paint,
    );

    canvas.drawLine(
      Offset(highTemperaturePosition, lineCenterY),
      Offset(lineWidth, lineCenterY),
      paint,
    );
  }

  @override
  bool shouldRepaint(_TemperatureRangeLinePainter oldDelegate) {
    return oldDelegate.lowTemperature != lowTemperature ||
        oldDelegate.highTemperature != highTemperature ||
        oldDelegate.gradientColors != gradientColors;
  }
}
