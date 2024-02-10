import 'package:flutter/material.dart';

class GradientLineWithMarker extends StatelessWidget {
  final List<Color> colors;
  final double height;
  final double borderRadius;
  final double markerPosition;

  const GradientLineWithMarker({
    Key? key,
    required this.colors,
    required this.markerPosition,
    this.height = 20,
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          Positioned(
            left: markerPosition >= 0 && markerPosition <= 1
                ? constraints.maxWidth * markerPosition
                : 0,
            bottom: -3,
            child: Column(
              children: [
                Container(
                  width: 0,
                  height: 0,
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(width: 4, color: Colors.transparent),
                      right: BorderSide(width: 4, color: Colors.transparent),
                      bottom: BorderSide(width: 4, color: Colors.white),
                    ),
                  ),
                ),
                Container(width: 1, height: 10, color: Colors.white),
                Container(
                  width: 0,
                  height: 0,
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(width: 4, color: Colors.transparent),
                      right: BorderSide(width: 4, color: Colors.transparent),
                      top: BorderSide(width: 4, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
