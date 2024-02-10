import 'package:flutter/material.dart';
import 'package:weather_app/pages/city/city_list.dart';
import 'package:weather_app/pages/home/widgets/weather_card.dart';
import 'package:weather_app/router/router.dart';
import 'package:weather_app/theme/colors.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  static const route = '/home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late FocusNode _searchFocusNode;
  late AnimationController _animationController;
  late AnimationController _searchAnimationController;
  String searchQuery = '';
  TextEditingController textController = TextEditingController();

  bool isSearchBarFocused = false;

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

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
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
                      AnimatedContainer(
                        height: isSearchBarFocused ? 0 : 60,
                        duration: const Duration(milliseconds: 250),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'City List',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Light rain for the next hour',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: TextField(
                                focusNode: _searchFocusNode,
                                controller: textController,
                                keyboardAppearance: Brightness.dark,
                                onTapOutside: (event) {
                                  if (searchQuery.isEmpty) {
                                    _searchFocusNode.unfocus();
                                  }
                                },
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: WeatherColors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: 'Search for a city or airport',
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: WeatherColors.ev1,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFAAAAAA))),
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  prefixIcon: const Icon(Icons.search,
                                      color: Color(0xFF7F7F7F)),
                                  suffixIcon: searchQuery.isNotEmpty
                                      ? TextButton(
                                          onPressed: () {
                                            textController.clear();
                                          },
                                          child: const Icon(
                                              size: 18,
                                              Icons.cancel,
                                              color: Color(0xFFAAAAAA)),
                                        )
                                      : null,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                cursorColor: WeatherColors.white,
                              ),
                            ),
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            child: SizedBox(
                              width: isSearchBarFocused ? null : 0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                                            fontWeight: FontWeight.w900,
                                            color: WeatherColors.white),
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
                                0, -50 + 50 * _animationController.value),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
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
                                      WeatherCard(
                                        city: 'Fresno',
                                        time: '03:22 AM',
                                        degrees: '12',
                                        forecast: 'Light rain forecasted',
                                        onPressed: () async {
                                          router.push(CityList.route);
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
                                                    _animationController.value),
                                        child: AnimatedOpacity(
                                          opacity:
                                              1 * _animationController.value,
                                          duration:
                                              const Duration(milliseconds: 25),
                                          child: const Wrap(
                                            runSpacing: 12,
                                            children: [
                                              WeatherCard(
                                                city: 'New York',
                                                time: '03:22 AM',
                                                degrees: '4',
                                                forecast:
                                                    'Light rain forecasted',
                                                fontColor: WeatherColors.white,
                                                backgroundColor:
                                                    WeatherColors.ev1,
                                              ),
                                              WeatherCard(
                                                city: 'Vancouver',
                                                time: '03:22 AM',
                                                degrees: '8',
                                                forecast:
                                                    'Light rain forecasted',
                                                fontColor: WeatherColors.white,
                                                backgroundColor:
                                                    WeatherColors.ev1,
                                              ),
                                              WeatherCard(
                                                city: 'London',
                                                time: '03:22 AM',
                                                degrees: '13',
                                                forecast:
                                                    'Light rain forecasted',
                                                fontColor: WeatherColors.white,
                                                backgroundColor:
                                                    WeatherColors.ev1,
                                              ),
                                              WeatherCard(
                                                city: 'Fresno',
                                                time: '03:22 AM',
                                                degrees: '27',
                                                forecast:
                                                    'Light rain forecasted',
                                                fontColor: WeatherColors.white,
                                                backgroundColor:
                                                    WeatherColors.ev1,
                                              ),
                                              WeatherCard(
                                                city: 'California',
                                                time: '03:22 AM',
                                                degrees: '12',
                                                forecast:
                                                    'Light rain forecasted',
                                                fontColor: WeatherColors.white,
                                                backgroundColor:
                                                    WeatherColors.ev1,
                                              ),
                                            ],
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
                        IgnorePointer(
                          ignoring: !isSearchBarFocused,
                          child: AnimatedOpacity(
                            opacity: isSearchBarFocused ? 1 : 0,
                            duration: Duration(
                                milliseconds: searchQuery.isNotEmpty ? 0 : 700),
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: WeatherColors.black.withOpacity(
                                        textController.text.isEmpty ? 0.7 : 1)),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: textController.text.isNotEmpty
                                      ? SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Wrap(
                                              spacing: 10,
                                              children: [
                                                DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: WeatherColors.ev1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: SizedBox(
                                                      width: double.infinity,
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Melbourne',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall,
                                                              ),
                                                              Text(
                                                                ', FL, United States',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        color: WeatherColors
                                                                            .secondaryFont),
                                                              )
                                                            ],
                                                          ))),
                                                ),
                                                SizedBox(
                                                    width: double.infinity,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Melbourne',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                            Text(
                                                              ', FL, United States',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      color: WeatherColors
                                                                          .secondaryFont),
                                                            )
                                                          ],
                                                        ))),
                                                SizedBox(
                                                    width: double.infinity,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Melbourne',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                            Text(
                                                              ', FL, United States',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      color: WeatherColors
                                                                          .secondaryFont),
                                                            )
                                                          ],
                                                        ))),
                                                SizedBox(
                                                    width: double.infinity,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Melbourne',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                            Text(
                                                              ', FL, United States',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      color: WeatherColors
                                                                          .secondaryFont),
                                                            )
                                                          ],
                                                        ))),
                                                SizedBox(
                                                    width: double.infinity,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Melbourne',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                            Text(
                                                              ', FL, United States',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      color: WeatherColors
                                                                          .secondaryFont),
                                                            )
                                                          ],
                                                        ))),
                                                SizedBox(
                                                    width: double.infinity,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Melbourne',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                            Text(
                                                              ', FL, United States',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      color: WeatherColors
                                                                          .secondaryFont),
                                                            )
                                                          ],
                                                        ))),
                                                SizedBox(
                                                    width: double.infinity,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Melbourne',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                            Text(
                                                              ', FL, United States',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      color: WeatherColors
                                                                          .secondaryFont),
                                                            )
                                                          ],
                                                        ))),
                                                SizedBox(
                                                    width: double.infinity,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Melbourne',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                            Text(
                                                              ', FL, United States',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      color: WeatherColors
                                                                          .secondaryFont),
                                                            )
                                                          ],
                                                        ))),
                                                SizedBox(
                                                    width: double.infinity,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Melbourne',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                            Text(
                                                              ', FL, United States',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      color: WeatherColors
                                                                          .secondaryFont),
                                                            )
                                                          ],
                                                        ))),
                                                SizedBox(
                                                    width: double.infinity,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Melbourne',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                            Text(
                                                              ', FL, United States',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      color: WeatherColors
                                                                          .secondaryFont),
                                                            )
                                                          ],
                                                        ))),
                                                SizedBox(
                                                    width: double.infinity,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Melbourne',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                            Text(
                                                              ', FL, United States',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      color: WeatherColors
                                                                          .secondaryFont),
                                                            )
                                                          ],
                                                        ))),
                                              ],
                                            ),
                                          ),
                                        )
                                      : null,
                                )),
                          ),
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
}
