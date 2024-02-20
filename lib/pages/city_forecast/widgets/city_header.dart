import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:weather_app/widgets/gradient_container.dart';

import '../util/util.dart';

class CityHeader extends StatefulWidget {
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
  State<CityHeader> createState() => _CityHeaderState();
}

class _CityHeaderState extends State<CityHeader> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CityHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.condition != oldWidget.condition &&
        widget.condition.isNotEmpty) {
      _controller?.dispose();
      _initializeVideo();
    }
  }

  void _initializeVideo() {
    _controller =
        VideoPlayerController.asset(getWeatherVideoAsset(widget.condition));
    _controller?.initialize().then((_) {
      _controller
        ?..play()
        ..setLooping(true);
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color(0xFF252525),
          ),
          child: Stack(
            children: [
              Stack(
                children: [
                  if (widget.condition.isNotEmpty) VideoPlayer(_controller!),
                  Container(color: WeatherColors.black.withOpacity(0.4)),
                ],
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: AnimatedOpacity(
                              opacity: widget.isLoading ? 0 : 1,
                              duration: const Duration(seconds: 2),
                              child: Column(
                                children: [
                                  Wrap(
                                    spacing: 5,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    direction: Axis.vertical,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Text(widget.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      height: 1,
                                                      fontSize: 30,
                                                      color:
                                                          WeatherColors.white)),
                                        ],
                                      ),
                                      Text(widget.airQualityMessage,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  height: 1,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: WeatherColors.white)),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(widget.currentTemp,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  fontSize: 90,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1,
                                                  color: WeatherColors.white,
                                                )),
                                        Text('°',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    fontSize: 50,
                                                    fontWeight: FontWeight.w100,
                                                    color: WeatherColors.white))
                                      ],
                                    ),
                                  ),
                                  Wrap(
                                    spacing: 10,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      if (widget.iconAsset.isNotEmpty)
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
                                                    iconAsset:
                                                        widget.iconAsset)),
                                          ),
                                        ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(widget.condition,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    height: 1,
                                                    fontSize: 18,
                                                    color:
                                                        WeatherColors.white)),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Wrap(
                                      spacing: 10,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text('H: ${widget.tempHi}°',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    height: 1,
                                                    fontSize: 15,
                                                    color:
                                                        WeatherColors.white)),
                                        const Icon(
                                          size: 7,
                                          Icons.circle,
                                          color: WeatherColors.white,
                                        ),
                                        Text('L: ${widget.tempLow}°',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    height: 1,
                                                    fontSize: 15,
                                                    color: WeatherColors.white))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding:
                                      EdgeInsets.only(right: 15, bottom: 15),
                                  child: Icon(
                                      size: 30,
                                      Icons.filter_list_rounded,
                                      color: WeatherColors.white),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
