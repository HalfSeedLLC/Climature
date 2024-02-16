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
            padding: EdgeInsets.all(15),
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
                )
              ],
            ),
          ),
        ),
      );
}
