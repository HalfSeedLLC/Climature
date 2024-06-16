import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../pages/city_forecast/city_forecast.dart';
import '../pages/city_forecast/cubit/forecast_cubit.dart';
import '../pages/home/home.dart';
import '../pages/home/widgets/city_list/cubit/city_list_cubit.dart';
import '../pages/landing/landing.dart';
import '../respository/weather_repository.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      maintainState: false,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Stack(
          children: [
            ColoredBox(
                color: Colors.black,
                child: FadeTransition(opacity: animation, child: child)),
          ],
        );
      });
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: Landing.route,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const Landing(),
      ),
    ),
    GoRoute(
      path: Home.route,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: BlocProvider(
          create: (context) => CityListCubit(
            weatherRepository:
                RepositoryProvider.of<WeatherRepository>(context),
          ),
          child: const Home(),
        ),
      ),
    ),
    GoRoute(
      name: CityForecast.name,
      path: '${CityForecast.route}/:city',
      pageBuilder: (context, state) {
        return buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (context) => ForecastCubit(
              city: state.pathParameters["city"] ?? '',
              weatherRepository:
                  RepositoryProvider.of<WeatherRepository>(context),
            ),
            child: const CityForecast(),
          ),
        );
      },
    ),
  ],
);
