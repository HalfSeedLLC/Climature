import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.title,
    this.onPressed,
    this.borderColor,
    this.color = Colors.black,
    this.backgroundColor = Colors.white,
    Key? key,
  }) : super(key: key);

  final String title;
  final void Function()? onPressed;
  final Color? borderColor;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border:
                borderColor != null ? Border.all(color: borderColor!) : null),
        child: TextButton(
          onPressed: onPressed,
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: Center(
              child: Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: color)),
            ),
          ),
        ),
      );
}
