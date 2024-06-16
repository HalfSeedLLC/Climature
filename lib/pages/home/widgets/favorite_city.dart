import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_card_data.dart';
import 'package:weather_app/pages/city_forecast/city_forecast.dart';
import 'package:weather_app/pages/home/widgets/action_icon.dart';
import 'package:weather_app/pages/home/widgets/city_list/cubit/city_list_cubit.dart';
import 'package:weather_app/pages/home/widgets/weather_card/weather_card.dart';
import 'package:weather_app/pages/home/widgets/weather_card/weather_card_skeleton.dart';
import 'package:weather_app/router/router.dart';
import 'package:weather_app/utils/localizations.dart';
import 'package:weather_app/utils/utils.dart';

class FavoriteCity extends StatelessWidget {
  const FavoriteCity({
    required this.isLoading,
    required this.isEditMode,
    required this.favoriteCity,
    Key? key,
  }) : super(key: key);

  final bool isLoading;
  final bool isEditMode;
  final WeatherCardData? favoriteCity;

  @override
  Widget build(BuildContext context) => isLoading
      ? const WeatherCardSkeleton()
      : favoriteCity == null
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text(
                  context.localizations.noCitySelected,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            )
          : Row(
              children: [
                Expanded(
                  child: WeatherCard(
                    isFavorite: true,
                    isEditMode: isEditMode,
                    city: favoriteCity!.location.name,
                    time: getUserFriendlyTime(dateTime: favoriteCity!.location.localTime),
                    degrees: favoriteCity!.current.tempF.toStringAsFixed(0),
                    forecast: favoriteCity!.current.condition.text,
                    iconAsset: favoriteCity!.current.condition.icon,
                    onPressed: () async {
                      router.pushNamed(CityForecast.name,
                          pathParameters: {'city': favoriteCity!.location.name});
                    },
                  ),
                ),
                if (isEditMode)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: ActionIcon(
                      icon: Icons.remove,
                      onPressed: () => context.read<CityListCubit>().removeFavoriteCity(),
                    ),
                  ),
              ],
            );
}
