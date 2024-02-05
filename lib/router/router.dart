import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/home/home.dart';
import '../pages/landing/landing.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: Landing.route,
      builder: (BuildContext context, GoRouterState state) => const Landing(),
    ),
    GoRoute(
      path: Home.route,
      builder: (BuildContext context, GoRouterState state) => const Home(),
    ),
  ],
);
