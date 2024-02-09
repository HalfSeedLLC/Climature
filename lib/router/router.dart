import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/pages/city/city_list.dart';

import '../pages/home/home.dart';
import '../pages/landing/landing.dart';

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
                context: context, state: state, child: const Landing())),
    GoRoute(
      path: Home.route,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: const Home()),
      // builder: (BuildContext context, GoRouterState state) => const Home(),
    ),
    GoRoute(
      path: CityList.route,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: const CityList()),
    )
  ],
);
