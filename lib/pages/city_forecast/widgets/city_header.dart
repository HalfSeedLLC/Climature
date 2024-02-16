import 'package:flutter/material.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:weather_app/widgets/gradient_container.dart';

class CityHeader extends StatelessWidget {
  const CityHeader({
    required this.title,
    required this.currentTemp,
    required this.condition,
    required this.tempHi,
    required this.tempLow,
    required this.iconAsset,
    required this.airQualityMessage,
    this.isLoading = false,
    Key? key,
  }) : super(key: key);

  final String title;
  final String condition;
  final String currentTemp;
  final String tempHi;
  final String tempLow;
  final String iconAsset;
  final String airQualityMessage;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
            color: WeatherColors.white,
            borderRadius: BorderRadius.circular(40)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
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
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              if (isLoading)
                                const GradientContainer(
                                  height: 30,
                                  width: 250,
                                  theme: SkeletonTheme.light,
                                ),
                              Text(title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          height: 1,
                                          fontSize: 30,
                                          color: WeatherColors.black)),
                            ],
                          ),
                          isLoading
                              ? const GradientContainer(
                                  height: 15,
                                  width: 200,
                                  theme: SkeletonTheme.light,
                                )
                              : Text(airQualityMessage,
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
                        child: isLoading
                            ? const GradientContainer(
                                height: 80,
                                width: 80,
                                borderRadius: 40,
                                theme: SkeletonTheme.light,
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(currentTemp,
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
                      isLoading
                          ? const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: GradientContainer(
                                height: 15,
                                width: 100,
                                theme: SkeletonTheme.light,
                              ),
                            )
                          : Wrap(
                              spacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                if (iconAsset.isNotEmpty)
                                  SizedBox(
                                    width: 20,
                                    height: 45,
                                    child: OverflowBox(
                                      maxWidth: double.infinity,
                                      maxHeight: double.infinity,
                                      child: Image.asset(
                                          width: 50,
                                          height: 50,
                                          getWeatherIconAsset(
                                              iconAsset: iconAsset)),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(condition,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              height: 1,
                                              fontSize: 18,
                                              color: WeatherColors.black)),
                                )
                              ],
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: isLoading
                            ? const GradientContainer(
                                height: 20,
                                width: 150,
                                theme: SkeletonTheme.light,
                              )
                            : Wrap(
                                spacing: 10,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text('H: $tempHi°',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              height: 1,
                                              fontSize: 15,
                                              color: WeatherColors.black)),
                                  const Icon(size: 7, Icons.circle),
                                  Text('L: $tempLow°',
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
      );
}
