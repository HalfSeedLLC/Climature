import 'package:flutter/material.dart';
import 'package:weather_app/theme/colors.dart';

class CityHeader extends StatelessWidget {
  const CityHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
                color: WeatherColors.slime,
                borderRadius: BorderRadius.circular(40)),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 5,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            direction: Axis.vertical,
                            children: [
                              Text('Melbourne',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          height: 1,
                                          fontSize: 30,
                                          color: WeatherColors.black)),
                              Text('Moderate',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          height: 1,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: WeatherColors.black)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('12',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontSize: 90,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1,
                                          color: WeatherColors.black,
                                        )),
                                Text('°',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontSize: 50,
                                            fontWeight: FontWeight.w100,
                                            color: WeatherColors.black))
                              ],
                            ),
                          ),
                          Wrap(
                            spacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(Icons.cloud),
                              Text('Mostly Clear',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          height: 1,
                                          fontSize: 18,
                                          color: WeatherColors.black))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Wrap(
                              spacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text('H: 25°',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            height: 1,
                                            fontSize: 15,
                                            color: WeatherColors.black)),
                                const Icon(size: 7, Icons.circle),
                                Text('L: 17°',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            height: 1,
                                            fontSize: 15,
                                            color: WeatherColors.black))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 15, bottom: 15),
                            child: Icon(
                                size: 30,
                                Icons.filter_list_rounded,
                                color: WeatherColors.black),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}
