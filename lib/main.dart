import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/router/router.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:weather_app/respository/weather_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final weatherRepository = WeatherRepository();

  runApp(RepositoryProvider(
    create: (context) => weatherRepository,
    child: const WeatherApp(),
  ));
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Weather App',
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Gilroy-Regular',
          textButtonTheme: const TextButtonThemeData(
              style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStatePropertyAll(Colors.transparent),
                  padding: MaterialStatePropertyAll(EdgeInsets.zero))),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              height: 1,
              fontSize: 50,
              letterSpacing: 0,
              color: WeatherColors.white,
              fontFamily: 'Gilroy-Black',
              fontWeight: FontWeight.w900,
            ),
            headlineMedium: TextStyle(
              height: 1,
              fontSize: 30,
              letterSpacing: 0,
              color: WeatherColors.white,
              fontFamily: 'Gilroy-SemiBold',
              fontWeight: FontWeight.w600,
            ),
            headlineSmall: TextStyle(
              height: 1,
              fontSize: 20,
              letterSpacing: 0,
              color: WeatherColors.white,
              fontFamily: 'Gilroy-SemiBold',
              fontWeight: FontWeight.w500,
            ),
            titleLarge: TextStyle(
              height: 1,
              fontSize: 50,
              letterSpacing: 0,
              color: WeatherColors.black,
              fontFamily: 'Gilroy-SemiBold',
              fontWeight: FontWeight.w600,
            ),
            titleMedium: TextStyle(
              height: 1,
              fontSize: 50,
              letterSpacing: 0,
              color: WeatherColors.black,
              fontFamily: 'Gilroy-Regular',
              fontWeight: FontWeight.w100,
            ),
            labelLarge: TextStyle(
              fontSize: 20,
              fontFamily: 'Gilroy-Bold',
              fontWeight: FontWeight.w400,
              color: WeatherColors.black,
            ),
            labelMedium: TextStyle(
              fontSize: 16,
              fontFamily: 'Gilroy-Bold',
              fontWeight: FontWeight.w200,
              color: WeatherColors.black,
            ),
            labelSmall: TextStyle(
              height: 1.5,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: WeatherColors.secondaryFont,
            ),
            bodyLarge: TextStyle(
              height: 1.5,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: WeatherColors.secondaryFont,
            ),
            bodyMedium: TextStyle(
              height: 1.25,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: WeatherColors.secondaryFont,
            ),
            bodySmall: TextStyle(
                height: 1.25,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: WeatherColors.white),
          )),
      routerConfig: router,
    );
  }
}
