import 'package:flutter/material.dart';
import 'package:weather_app/pages/home/home.dart';
import 'package:weather_app/router/router.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:weather_app/widgets/action_button.dart';

class Landing extends StatelessWidget {
  const Landing({
    Key? key,
  }) : super(key: key);

  static const route = '/';

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -40,
              left: -90,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: const Color(0xFF232323),
                    borderRadius: BorderRadius.circular(800)),
                child: SizedBox(
                    width: 415,
                    height: 415,
                    child: Stack(children: [
                      Positioned(
                          top: 100,
                          left: 90,
                          child: Image.asset('assets/images/cloud.png')),
                    ])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200, left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('TRUSTED',
                      style: Theme.of(context).textTheme.headlineLarge),
                  Text('WEATHER',
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                              background: Paint()..color = Colors.transparent,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1
                                ..color = WeatherColors.white,
                              fontWeight: FontWeight.w500)),
                  Text('FORECAST',
                      style: Theme.of(context).textTheme.headlineLarge),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: 300,
                      child: Text(
                        'Get to know your weather maps and radar precipitation forecast',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: ActionButton(
              title: 'GET STARTED',
              onPressed: () => router.go(Home.route),
            ),
          ),
        ),
      );
}
