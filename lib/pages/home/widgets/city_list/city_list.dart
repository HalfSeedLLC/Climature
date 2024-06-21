import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_card_data.dart';
import 'package:weather_app/pages/city_forecast/city_forecast.dart';
import 'package:weather_app/pages/home/widgets/action_icon.dart';
import 'package:weather_app/pages/home/widgets/city_list/cubit/city_list_cubit.dart';
import 'package:weather_app/pages/home/widgets/weather_card/weather_card.dart';
import 'package:weather_app/pages/home/widgets/weather_card/weather_card_skeleton.dart';
import 'package:weather_app/router/router.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:weather_app/utils/localizations.dart';
import 'package:weather_app/utils/utils.dart';

class CityList extends StatelessWidget {
  const CityList({
    required this.isLoading,
    required this.isEditMode,
    required this.favoritesData,
    required this.favoritesNames,
    required this.animationController,
    Key? key,
  }) : super(key: key);

  final bool isLoading;
  final bool isEditMode;
  final List<WeatherCardData> favoritesData;
  final List<String> favoritesNames;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) => Transform.translate(
        offset: Offset(0, -25 + 25 * animationController.value),
        child: AnimatedOpacity(
          opacity: 1 * animationController.value,
          duration: const Duration(milliseconds: 25),
          child: isLoading
              ? Wrap(
                  runSpacing: 12,
                  children: List.generate(7, (i) => const WeatherCardSkeleton()),
                )
              : favoritesData.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Center(
                        child: Text(
                          context.localizations.noFavoritesAdded,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                  : Wrap(
                      runSpacing: 12,
                      children: List.generate(
                        favoritesData.length,
                        (i) => Row(
                          children: [
                            Expanded(
                              child: WeatherCard(
                                isEditMode: isEditMode,
                                city: favoritesData.elementAt(i).location.name,
                                time: getUserFriendlyTime(
                                    dateTime: favoritesData.elementAt(i).location.localTime),
                                degrees:
                                    favoritesData.elementAt(i).current.tempF.toStringAsFixed(0),
                                forecast: favoritesData.elementAt(i).current.condition.text,
                                fontColor: WeatherColors.white,
                                backgroundColor: WeatherColors.ev1,
                                iconAsset: favoritesData.elementAt(i).current.condition.icon,
                                onPressed: () async {
                                  router.pushNamed(CityForecast.name, pathParameters: {
                                    'city': favoritesData.elementAt(i).location.name
                                  });
                                },
                              ),
                            ),
                            if (isEditMode)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 25,
                                  children: [
                                    ActionIcon(
                                      onPressed: () async {
                                        Future.wait([
                                          context.read<CityListCubit>().removeFromFavorites(
                                              city: favoritesNames.elementAt(i)),
                                          HapticFeedback.mediumImpact()
                                        ]);
                                      },
                                      icon: Icons.remove,
                                    ),
                                    ActionIcon(
                                      onPressed: () async {
                                        Future.wait([
                                          context.read<CityListCubit>().updateFavoriteCity(
                                              city: favoritesData.elementAt(i).location.name),
                                          HapticFeedback.mediumImpact()
                                        ]);
                                      },
                                      icon: Icons.star,
                                      backgroundColor: const Color(0xFF3F67D8),
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
        ),
      );
}
