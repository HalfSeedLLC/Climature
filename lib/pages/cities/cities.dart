import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/pages/cities/widgets/city_list/city_list.dart';
import 'package:weather_app/pages/cities/widgets/weather_card/weather_card_skeleton.dart';
import 'package:weather_app/pages/city_forecast/city_forecast.dart';
import 'package:weather_app/pages/cities/widgets/weather_card/weather_card.dart';
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
  String searchQuery = '';
  late FocusNode _searchFocusNode;
  late AnimationController _animationController;
  late AnimationController _searchAnimationController;
  TextEditingController textController = TextEditingController();

  bool isSearchBarFocused = false;
  final _debouncer = Debouncer(milliseconds: 300);

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
    context.read<CityListCubit>().searchCity(searchQuery: searchQuery);
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget
      build(BuildContext context) => BlocBuilder<CityListCubit, CityListState>(
            builder: (blocContext, state) {
              return AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return BlocBuilder<CityListCubit, CityListState>(
                      builder: (context, state) {
                        return SafeArea(
                          bottom: false,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 25, left: 25, right: 25),
                            child: Scaffold(
                              backgroundColor: WeatherColors.black,
                              body: Column(
                                children: [
                                  Wrap(
                                    children: [
                                      AnimatedContainer(
                                        height: isSearchBarFocused ? 0 : 60,
                                        duration:
                                            const Duration(milliseconds: 250),
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
                                                    'Currently ${state.favoriteCityMeta?.current.condition.text} conditions',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  context
                                                      .read<CityListCubit>()
                                                      .toggleEditMode();
                                                  HapticFeedback.mediumImpact();
                                                },
                                                child: state.isEditMode
                                                    ? const Icon(
                                                        size: 30,
                                                        Icons.cancel_outlined,
                                                        color:
                                                            WeatherColors.white)
                                                    : const Icon(
                                                        size: 30,
                                                        Icons.pending_outlined,
                                                        color: WeatherColors
                                                            .white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: TextField(
                                                  focusNode: _searchFocusNode,
                                                  controller: textController,
                                                  keyboardAppearance:
                                                      Brightness.dark,
                                                  onTapOutside: (event) {
                                                    if (searchQuery.isEmpty) {
                                                      _searchFocusNode
                                                          .unfocus();
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
                                                          color: WeatherColors
                                                              .white),
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    hintText:
                                                        'Search for a city or airport',
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    fillColor:
                                                        WeatherColors.ev1,
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xFFAAAAAA))),
                                                    hintStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                    prefixIcon: const Icon(
                                                        Icons.search,
                                                        color:
                                                            Color(0xFF7F7F7F)),
                                                    suffixIcon: searchQuery
                                                            .isNotEmpty
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
                                                  cursorColor:
                                                      WeatherColors.white,
                                                )),
                                          ),
                                          AnimatedSize(
                                            duration: const Duration(
                                                milliseconds: 200),
                                            child: SizedBox(
                                              width:
                                                  isSearchBarFocused ? null : 0,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                        _animationController
                                                            .value),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: Column(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Your City',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineSmall,
                                                      ),
                                                      const SizedBox(
                                                          height: 15),
                                                      state.isLoading
                                                          ? const WeatherCardSkeleton()
                                                          : state.favoriteCityMeta ==
                                                                  null
                                                              ? Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          40),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "No city selected",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          WeatherCard(
                                                                        isFavorite:
                                                                            true,
                                                                        isEditMode:
                                                                            state.isEditMode,
                                                                        city: state.favoriteCityMeta?.location.name ??
                                                                            '',
                                                                        time: getUserFriendlyTime(
                                                                            dateTime:
                                                                                state.favoriteCityMeta?.location.localTime ?? ''),
                                                                        degrees:
                                                                            state.favoriteCityMeta?.current.tempF.toStringAsFixed(0) ??
                                                                                '',
                                                                        forecast:
                                                                            state.favoriteCityMeta?.current.condition.text ??
                                                                                '',
                                                                        iconAsset:
                                                                            state.favoriteCityMeta?.current.condition.icon ??
                                                                                '',
                                                                        onPressed:
                                                                            () async {
                                                                          router.pushNamed(
                                                                              CityForecast.name,
                                                                              pathParameters: {
                                                                                'city': state.favoriteCityMeta!.location.name
                                                                              });
                                                                        },
                                                                      ),
                                                                    ),
                                                                    if (state
                                                                        .isEditMode)
                                                                      TextButton(
                                                                        style: const ButtonStyle(
                                                                            padding:
                                                                                MaterialStatePropertyAll(EdgeInsets.all(20))),
                                                                        onPressed:
                                                                            () async {
                                                                          Future
                                                                              .wait([
                                                                            context.read<CityListCubit>().removeFavoriteCity(),
                                                                            HapticFeedback.mediumImpact()
                                                                          ]);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              30,
                                                                          decoration: BoxDecoration(
                                                                              color: const Color(0xFFD10A2C),
                                                                              borderRadius: BorderRadius.circular(40)),
                                                                          child:
                                                                              const Center(
                                                                            child:
                                                                                Icon(
                                                                              size: 20,
                                                                              Icons.remove,
                                                                              color: WeatherColors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                  ],
                                                                ),
                                                      const SizedBox(
                                                          height: 30),
                                                      Text(
                                                        'Your favorites',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineSmall,
                                                      ),
                                                      const SizedBox(
                                                          height: 15),
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
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      25),
                                                          child: state.isLoading
                                                              ? Wrap(
                                                                  runSpacing:
                                                                      12,
                                                                  children: List
                                                                      .generate(
                                                                          7,
                                                                          (i) =>
                                                                              const WeatherCardSkeleton()),
                                                                )
                                                              : state.favoritesMeta
                                                                      .isEmpty
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              100),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'No favorites added',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Wrap(
                                                                      runSpacing:
                                                                          12,
                                                                      children:
                                                                          List.generate(
                                                                        state
                                                                            .favoritesMeta
                                                                            .length,
                                                                        (i) =>
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: WeatherCard(
                                                                                isEditMode: state.isEditMode,
                                                                                city: state.favoritesMeta.elementAt(i).location.name,
                                                                                time: getUserFriendlyTime(dateTime: state.favoritesMeta.elementAt(i).location.localTime),
                                                                                degrees: state.favoritesMeta.elementAt(i).current.tempF.toStringAsFixed(0),
                                                                                forecast: state.favoritesMeta.elementAt(i).current.condition.text,
                                                                                fontColor: WeatherColors.white,
                                                                                backgroundColor: WeatherColors.ev1,
                                                                                iconAsset: state.favoritesMeta.elementAt(i).current.condition.icon,
                                                                                onPressed: () async {
                                                                                  router.pushNamed(CityForecast.name, pathParameters: {
                                                                                    'city': state.favoritesMeta.elementAt(i).location.name
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                            if (state.isEditMode)
                                                                              Wrap(
                                                                                crossAxisAlignment: WrapCrossAlignment.center,
                                                                                spacing: 25,
                                                                                children: [
                                                                                  TextButton(
                                                                                    style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                                                                                    onPressed: () async {
                                                                                      Future.wait([
                                                                                        context.read<CityListCubit>().removeFromFavorites(city: state.favorites.elementAt(i)),
                                                                                        HapticFeedback.mediumImpact()
                                                                                      ]);
                                                                                    },
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(left: 15),
                                                                                      child: Container(
                                                                                        height: 30,
                                                                                        width: 30,
                                                                                        decoration: BoxDecoration(color: const Color(0xFFD10A2C), borderRadius: BorderRadius.circular(40)),
                                                                                        child: const Center(
                                                                                          child: Icon(
                                                                                            size: 20,
                                                                                            Icons.remove,
                                                                                            color: Colors.white,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  TextButton(
                                                                                    style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                                                                                    onPressed: () {
                                                                                      Future.wait([
                                                                                        context.read<CityListCubit>().updateFavoriteCity(city: state.favoritesMeta.elementAt(i).location.name),
                                                                                        HapticFeedback.mediumImpact()
                                                                                      ]);
                                                                                    },
                                                                                    child: Container(
                                                                                      height: 30,
                                                                                      width: 30,
                                                                                      decoration: BoxDecoration(
                                                                                        color: const Color(0xFF3F67D8),
                                                                                        borderRadius: BorderRadius.circular(40),
                                                                                      ),
                                                                                      child: const Center(
                                                                                        child: Icon(
                                                                                          size: 20,
                                                                                          Icons.star,
                                                                                          color: WeatherColors.white,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
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
                                          searchQuery: searchQuery,
                                          isSearchBarFocused:
                                              isSearchBarFocused,
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
