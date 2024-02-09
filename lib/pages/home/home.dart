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
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
          child: Scaffold(
            backgroundColor: WeatherColors.black,
            appBar: PreferredSize(
                preferredSize: const Size(double.infinity, 125),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City List',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Light rain for the next hour',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: WeatherColors.white),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Search for a city',
                          contentPadding: EdgeInsets.zero,
                          fillColor: WeatherColors.ev1,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Color(0xFFAAAAAA))),
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                          prefixIcon: const Icon(Icons.search,
                              color: Color(0xFF7F7F7F)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            body: SingleChildScrollView(
              child: Transform.translate(
                offset: Offset(0, -50 + 50 * _animationController.value),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 35),
                        Text(
                          'Your City',
                          style: Theme.of(context).textTheme.headlineSmall,
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
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 15),
                        Transform.translate(
                          offset:
                              Offset(0, -25 + 25 * _animationController.value),
                          child: AnimatedOpacity(
                            opacity: 1 * _animationController.value,
                            duration: const Duration(milliseconds: 25),
                            child: const Wrap(
                              runSpacing: 12,
                              children: [
                                WeatherCard(
                                  city: 'New York',
                                  time: '03:22 AM',
                                  degrees: '4',
                                  forecast: 'Light rain forecasted',
                                  fontColor: WeatherColors.white,
                                  backgroundColor: WeatherColors.ev1,
                                ),
                                WeatherCard(
                                  city: 'Vancouver',
                                  time: '03:22 AM',
                                  degrees: '8',
                                  forecast: 'Light rain forecasted',
                                  fontColor: WeatherColors.white,
                                  backgroundColor: WeatherColors.ev1,
                                ),
                                WeatherCard(
                                  city: 'London',
                                  time: '03:22 AM',
                                  degrees: '13',
                                  forecast: 'Light rain forecasted',
                                  fontColor: WeatherColors.white,
                                  backgroundColor: WeatherColors.ev1,
                                ),
                                WeatherCard(
                                  city: 'Fresno',
                                  time: '03:22 AM',
                                  degrees: '27',
                                  forecast: 'Light rain forecasted',
                                  fontColor: WeatherColors.white,
                                  backgroundColor: WeatherColors.ev1,
                                ),
                                WeatherCard(
                                  city: 'California',
                                  time: '03:22 AM',
                                  degrees: '12',
                                  forecast: 'Light rain forecasted',
                                  fontColor: WeatherColors.white,
                                  backgroundColor: WeatherColors.ev1,
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
        );
      });
}
