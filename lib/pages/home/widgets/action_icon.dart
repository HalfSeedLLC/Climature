import 'package:climature/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActionIcon extends StatelessWidget {
  const ActionIcon({
    required this.onPressed,
    required this.icon,
    this.iconColor = WeatherColors.white,
    this.backgroundColor = const Color(0xFFD10A2C),
    Key? key,
  }) : super(key: key);

  final void Function()? onPressed;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
          backgroundColor: WidgetStatePropertyAll(backgroundColor)),
      onPressed: () {
        onPressed?.call();
        HapticFeedback.mediumImpact();
      },
      child: SizedBox(
        height: 30,
        width: 30,
        child: Center(
          child: Icon(
            size: 20,
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
