import 'package:flutter/material.dart';

class FutureForecast extends StatelessWidget {
  const FutureForecast({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 80), child: SizedBox()),
      );
}
