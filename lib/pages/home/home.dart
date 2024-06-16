import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/pages/city_forecast/city_forecast.dart';
import 'package:weather_app/pages/home/widgets/action_icon.dart';
import 'package:weather_app/pages/home/widgets/city_list/city_list.dart';
import 'package:weather_app/pages/home/widgets/home_header.dart';
import 'package:weather_app/pages/home/widgets/home_search_bar.dart';
import 'package:weather_app/pages/home/widgets/weather_card/weather_card.dart';
import 'package:weather_app/pages/home/widgets/weather_card/weather_card_skeleton.dart';
import 'package:weather_app/router/router.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:weather_app/utils/utils.dart';

import '../../utils/localizations.dart';
import '../../widgets/debounce.dart';
import 'widgets/city_list/cubit/city_list_cubit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const route = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController _animationController;

  String _searchQuery = '';
  bool isSearchBarFocused = false;
  final _debouncer = Debouncer(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _animationController.forward();
  }

  void _onSearchEvent(String searchQuery) {
    setState(() {
      _searchQuery = searchQuery;
    });

    _debouncer.run(() => _searchCities(context: context, city: searchQuery));
  }

  void _onSearchFocusEvent(bool isSearchBarFocused) {
    setState(() {
      this.isSearchBarFocused = isSearchBarFocused;
    });
  }

  void _searchCities({required BuildContext context, required String city}) {
    context.read<CityListCubit>().searchCity(searchQuery: _searchQuery);
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<CityListCubit, CityListState>(
        builder: (blocContext, state) {
          return AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                    child: Scaffold(
                      backgroundColor: WeatherColors.black,
                      body: Column(
                        children: [
                          Wrap(
                            children: [
                              HomeHeader(
                                currentCondition:
                                    state.favoriteCityMeta?.current.condition.text ?? '',
                                isSearchBarFocused: isSearchBarFocused,
                                isEditMode: state.isEditMode,
                              ),
                              HomeSearchBar(
                                onSearchEvent: _onSearchEvent,
                                onSearchFocusEvent: _onSearchFocusEvent,
                              ),
                            ],
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  child: Transform.translate(
                                    offset: Offset(0, -50 + 50 * _animationController.value),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      child: Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                context.localizations.yourCity,
                                                style: Theme.of(context).textTheme.headlineSmall,
                                              ),
                                              const SizedBox(height: 15),
                                              state.isLoading
                                                  ? const WeatherCardSkeleton()
                                                  : state.favoriteCityMeta == null
                                                      ? Padding(
                                                          padding: const EdgeInsets.symmetric(
                                                              vertical: 40),
                                                          child: Center(
                                                            child: Text(
                                                              context.localizations.noCitySelected,
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                          ),
                                                        )
                                                      : Row(
                                                          children: [
                                                            Expanded(
                                                              child: WeatherCard(
                                                                isFavorite: true,
                                                                isEditMode: state.isEditMode,
                                                                city: state.favoriteCityMeta
                                                                        ?.location.name ??
                                                                    '',
                                                                time: getUserFriendlyTime(
                                                                    dateTime: state.favoriteCityMeta
                                                                            ?.location.localTime ??
                                                                        ''),
                                                                degrees: state.favoriteCityMeta
                                                                        ?.current.tempF
                                                                        .toStringAsFixed(0) ??
                                                                    '',
                                                                forecast: state.favoriteCityMeta
                                                                        ?.current.condition.text ??
                                                                    '',
                                                                iconAsset: state.favoriteCityMeta
                                                                        ?.current.condition.icon ??
                                                                    '',
                                                                onPressed: () async {
                                                                  router.pushNamed(
                                                                      CityForecast.name,
                                                                      pathParameters: {
                                                                        'city': state
                                                                            .favoriteCityMeta!
                                                                            .location
                                                                            .name
                                                                      });
                                                                },
                                                              ),
                                                            ),
                                                            if (state.isEditMode)
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(
                                                                    horizontal: 15.0),
                                                                child: ActionIcon(
                                                                  icon: Icons.remove,
                                                                  onPressed: () => context
                                                                      .read<CityListCubit>()
                                                                      .removeFavoriteCity(),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                              const SizedBox(height: 30),
                                              Text(
                                                context.localizations.yourFavorites,
                                                style: Theme.of(context).textTheme.headlineSmall,
                                              ),
                                              const SizedBox(height: 15),
                                              Transform.translate(
                                                offset: Offset(
                                                    0, -25 + 25 * _animationController.value),
                                                child: AnimatedOpacity(
                                                  opacity: 1 * _animationController.value,
                                                  duration: const Duration(milliseconds: 25),
                                                  child: state.isLoading
                                                      ? Wrap(
                                                          runSpacing: 12,
                                                          children: List.generate(7,
                                                              (i) => const WeatherCardSkeleton()),
                                                        )
                                                      : state.favoritesMeta.isEmpty
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets.only(top: 100),
                                                              child: Center(
                                                                child: Text(
                                                                  context.localizations
                                                                      .noFavoritesAdded,
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium,
                                                                ),
                                                              ),
                                                            )
                                                          : Wrap(
                                                              runSpacing: 12,
                                                              children: List.generate(
                                                                state.favoritesMeta.length,
                                                                (i) => Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: WeatherCard(
                                                                        isEditMode:
                                                                            state.isEditMode,
                                                                        city: state.favoritesMeta
                                                                            .elementAt(i)
                                                                            .location
                                                                            .name,
                                                                        time: getUserFriendlyTime(
                                                                            dateTime: state
                                                                                .favoritesMeta
                                                                                .elementAt(i)
                                                                                .location
                                                                                .localTime),
                                                                        degrees: state.favoritesMeta
                                                                            .elementAt(i)
                                                                            .current
                                                                            .tempF
                                                                            .toStringAsFixed(0),
                                                                        forecast: state
                                                                            .favoritesMeta
                                                                            .elementAt(i)
                                                                            .current
                                                                            .condition
                                                                            .text,
                                                                        fontColor:
                                                                            WeatherColors.white,
                                                                        backgroundColor:
                                                                            WeatherColors.ev1,
                                                                        iconAsset: state
                                                                            .favoritesMeta
                                                                            .elementAt(i)
                                                                            .current
                                                                            .condition
                                                                            .icon,
                                                                        onPressed: () async {
                                                                          router.pushNamed(
                                                                              CityForecast.name,
                                                                              pathParameters: {
                                                                                'city': state
                                                                                    .favoritesMeta
                                                                                    .elementAt(i)
                                                                                    .location
                                                                                    .name
                                                                              });
                                                                        },
                                                                      ),
                                                                    ),
                                                                    if (state.isEditMode)
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal: 15.0),
                                                                        child: Wrap(
                                                                          crossAxisAlignment:
                                                                              WrapCrossAlignment
                                                                                  .center,
                                                                          spacing: 25,
                                                                          children: [
                                                                            ActionIcon(
                                                                              onPressed: () async {
                                                                                Future.wait([
                                                                                  context
                                                                                      .read<
                                                                                          CityListCubit>()
                                                                                      .removeFromFavorites(
                                                                                          city: state
                                                                                              .favorites
                                                                                              .elementAt(
                                                                                                  i)),
                                                                                  HapticFeedback
                                                                                      .mediumImpact()
                                                                                ]);
                                                                              },
                                                                              icon: Icons.remove,
                                                                            ),
                                                                            ActionIcon(
                                                                              onPressed: () async {
                                                                                Future.wait([
                                                                                  context
                                                                                      .read<
                                                                                          CityListCubit>()
                                                                                      .updateFavoriteCity(
                                                                                          city: state
                                                                                              .favoritesMeta
                                                                                              .elementAt(
                                                                                                  i)
                                                                                              .location
                                                                                              .name),
                                                                                  HapticFeedback
                                                                                      .mediumImpact()
                                                                                ]);
                                                                              },
                                                                              icon: Icons.star,
                                                                              backgroundColor:
                                                                                  const Color(
                                                                                      0xFF3F67D8),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                CityList(
                                  isSearchBarFocused: isSearchBarFocused,
                                  isSearchEmpty: _searchQuery.isEmpty,
                                  onDismissSearchEvent: () {
                                    setState(() {
                                      _searchQuery = '';
                                      isSearchBarFocused = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      );
}
