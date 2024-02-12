import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/pages/cities/widgets/city_list/city_list.dart';
import 'package:weather_app/pages/city_forecast/city_forecast.dart';
import 'package:weather_app/pages/cities/widgets/weather_card.dart';
import 'package:weather_app/router/router.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/widgets/debounce.dart';

import 'widgets/city_list/cubit/city_list_cubit.dart';

class Cities extends StatefulWidget {
  const Cities({
    Key? key,
  }) : super(key: key);

  static const route = '/Cities';
  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> with TickerProviderStateMixin {
  late FocusNode _searchFocusNode;
  late AnimationController _animationController;
  late AnimationController _searchAnimationController;
  String searchQuery = '';
  TextEditingController textController = TextEditingController();

  bool isSearchBarFocused = false;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    _searchAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    _animationController.forward();

    _searchFocusNode = FocusNode();
    _searchFocusNode.addListener(_onSearchFocusChanged);
    textController.addListener(_onTextChanged);
  }

  void _onSearchFocusChanged() {
    setState(() {
      isSearchBarFocused = _searchFocusNode.hasFocus;
    });
    animateSearchBar();
  }

  void _onTextChanged() {
    setState(() {
      searchQuery = textController.text;
    });
  }

  void animateSearchBar() {
    if (isSearchBarFocused) {
      _searchAnimationController.reverse();
    } else {
      _searchAnimationController.forward();
    }
  }

  void _searchCities({required BuildContext context, required String city}) {
    context.read<CityListCubit>().getCity(searchQuery: searchQuery);
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CityListCubit, CityListState>(
        builder: (context, state) {
          return AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return BlocBuilder<CityListCubit, CityListState>(
                  builder: (context, state) {
                    return SafeArea(
                      bottom: false,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 25, left: 25, right: 25),
                        child: Scaffold(
                          backgroundColor: WeatherColors.black,
                          body: Column(
                            children: [
                              Wrap(
                                children: [
                                  AnimatedContainer(
                                    height: isSearchBarFocused ? 0 : 60,
                                    duration: const Duration(milliseconds: 250),
                                    child: SingleChildScrollView(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'City List',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Light rain for the next hour',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () => print('edit'),
                                            child: const Icon(
                                                size: 30,
                                                Icons.pending_outlined,
                                                color: WeatherColors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: TextField(
                                              focusNode: _searchFocusNode,
                                              controller: textController,
                                              keyboardAppearance:
                                                  Brightness.dark,
                                              onTapOutside: (event) {
                                                if (searchQuery.isEmpty) {
                                                  _searchFocusNode.unfocus();
                                                }
                                              },
                                              onChanged: (value) {
                                                _debouncer.run(() =>
                                                    _searchCities(
                                                        context: context,
                                                        city: value));
                                              },
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color:
                                                          WeatherColors.white),
                                              decoration: InputDecoration(
                                                filled: true,
                                                hintText:
                                                    'Search for a city or airport',
                                                contentPadding: EdgeInsets.zero,
                                                fillColor: WeatherColors.ev1,
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Color(
                                                                0xFFAAAAAA))),
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                prefixIcon: const Icon(
                                                    Icons.search,
                                                    color: Color(0xFF7F7F7F)),
                                                suffixIcon:
                                                    searchQuery.isNotEmpty
                                                        ? TextButton(
                                                            onPressed: () {
                                                              textController
                                                                  .clear();
                                                            },
                                                            child: const Icon(
                                                                size: 18,
                                                                Icons.cancel,
                                                                color: Color(
                                                                    0xFFAAAAAA)),
                                                          )
                                                        : null,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                              cursorColor: WeatherColors.white,
                                            )),
                                      ),
                                      AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: SizedBox(
                                          width: isSearchBarFocused ? null : 0,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: TextButton(
                                              onPressed: () {
                                                _searchFocusNode.unfocus();
                                                textController.clear();
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: WeatherColors
                                                            .white),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    SingleChildScrollView(
                                      child: Transform.translate(
                                        offset: Offset(
                                            0,
                                            -50 +
                                                50 *
                                                    _animationController.value),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: Column(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Your City',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall,
                                                  ),
                                                  const SizedBox(height: 15),
                                                  if (state
                                                      .favoritesMeta.isNotEmpty)
                                                    WeatherCard(
                                                      city: 'Fresno',
                                                      time: '03:22 AM',
                                                      degrees: '12',
                                                      forecast:
                                                          'Light rain forecasted',
                                                      iconAsset: state
                                                          .favoritesMeta
                                                          .first
                                                          .current
                                                          .condition
                                                          .icon,
                                                      onPressed: () async {
                                                        router.pushNamed(
                                                            CityForecast.name,
                                                            pathParameters: {
                                                              'city': 'Fresno'
                                                            });
                                                      },
                                                    ),
                                                  const SizedBox(height: 30),
                                                  Text(
                                                    'Favorite List',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall,
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Transform.translate(
                                                    offset: Offset(
                                                        0,
                                                        -25 +
                                                            25 *
                                                                _animationController
                                                                    .value),
                                                    child: AnimatedOpacity(
                                                      opacity: 1 *
                                                          _animationController
                                                              .value,
                                                      duration: const Duration(
                                                          milliseconds: 25),
                                                      child: Wrap(
                                                        runSpacing: 12,
                                                        children: List.generate(
                                                          state.favoritesMeta
                                                              .length,
                                                          (i) => WeatherCard(
                                                            city: state
                                                                .favoritesMeta
                                                                .elementAt(i)
                                                                .location
                                                                .name,
                                                            time: getUserFriendlyTime(
                                                                dateTime: state
                                                                    .favoritesMeta
                                                                    .elementAt(
                                                                        i)
                                                                    .location
                                                                    .localTime),
                                                            degrees: state
                                                                .favoritesMeta
                                                                .elementAt(i)
                                                                .current
                                                                .tempF
                                                                .toStringAsFixed(
                                                                    0),
                                                            forecast: state
                                                                .favoritesMeta
                                                                .elementAt(i)
                                                                .current
                                                                .condition
                                                                .text,
                                                            fontColor:
                                                                WeatherColors
                                                                    .white,
                                                            backgroundColor:
                                                                WeatherColors
                                                                    .ev1,
                                                            iconAsset: state
                                                                .favoritesMeta
                                                                .elementAt(i)
                                                                .current
                                                                .condition
                                                                .icon,
                                                            onPressed:
                                                                () async {
                                                              router.pushNamed(
                                                                  CityForecast
                                                                      .name,
                                                                  pathParameters: {
                                                                    'city': state
                                                                        .favoritesMeta
                                                                        .elementAt(
                                                                            i)
                                                                        .location
                                                                        .name
                                                                  });
                                                            },
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
                                      searchQuery: searchQuery,
                                      isSearchBarFocused: isSearchBarFocused,
                                      textController: textController,
                                      onDismissSearch: () {
                                        _searchFocusNode.unfocus();
                                        textController.clear();
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              });
        },
      );
}
