import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/pages/home/widgets/city_list/city_list.dart';
import 'package:weather_app/pages/home/widgets/city_list/cubit/city_list_cubit.dart';
import 'package:weather_app/pages/home/widgets/city_list/widgets/favorite_city.dart';
import 'package:weather_app/pages/home/widgets/home_header.dart';
import 'package:weather_app/pages/home/widgets/home_search_bar.dart';
import 'package:weather_app/theme/colors.dart';

import '../../utils/localizations.dart';
import '../../widgets/debounce.dart';
import 'widgets/city_list/widgets/city_search_results.dart';

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
                                              FavoriteCity(
                                                  isLoading: state.isLoading,
                                                  isEditMode: state.isEditMode,
                                                  favoriteCity: state.favoriteCityMeta),
                                              const SizedBox(height: 30),
                                              Text(
                                                context.localizations.yourFavorites,
                                                style: Theme.of(context).textTheme.headlineSmall,
                                              ),
                                              const SizedBox(height: 15),
                                              CityList(
                                                  isLoading: state.isLoading,
                                                  isEditMode: state.isEditMode,
                                                  favoritesMeta: state.favoritesMeta,
                                                  favoritesNames: state.favorites,
                                                  animationController: _animationController),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                CitySearchResults(
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
