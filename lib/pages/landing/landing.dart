import 'package:flutter/material.dart';
import 'package:weather_app/pages/city_list/city_list.dart';
import 'package:weather_app/router/router.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:weather_app/widgets/action_button.dart';

class Landing extends StatefulWidget {
  const Landing({
    Key? key,
  }) : super(key: key);

  static const route = '/';
  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Scaffold(
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
                        Transform.translate(
                          offset: Offset(0 + 90 * _animationController.value,
                              0 + 100 * _animationController.value),
                          child: Opacity(
                              opacity: 1 * _animationController.value,
                              child: Image.asset('assets/images/cloud.png')),
                        ),
                      ])),
                ),
              ),
              Transform.translate(
                offset: Offset(-305 + 305 * _animationController.value, 0),
                child: AnimatedOpacity(
                  opacity: 1 * _animationController.value,
                  duration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 250, left: 25, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('TRUSTED',
                            style: Theme.of(context).textTheme.headlineLarge),
                        Text('WEATHER',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                    background: Paint()
                                      ..color = Colors.transparent,
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
                ),
              ),
            ],
          ),
          bottomNavigationBar: Transform.translate(
            offset: Offset(0, 200 - 200 * _animationController.value),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: ActionButton(
                  title: 'GET STARTED',
                  onPressed: () => router.push(CityList.route),
                ),
              ),
            ),
          ),
        ),
      );
}
