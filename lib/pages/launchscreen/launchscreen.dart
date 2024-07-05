import 'package:climature/logic/initializer_cubit.dart';
import 'package:climature/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../landing/landing.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  static const String route = '/';

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> with TickerProviderStateMixin {
  bool _startAnimation = false;
  late AnimationController _animationController;

  late final InitializerCubit initializerCubit;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animationController.addStatusListener((status) {
      if (_animationController.value > 0.25) {
        if (initializerCubit.state.isFirstLoad) {
          _navigate(route: Landing.route);
        } else {
          _navigate(route: Home.route);
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _startAnimation = true;
        _animationController.forward();
      });
    });

    initializerCubit = context.read<InitializerCubit>();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigate({required String route}) {
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: const Color(0xFF18161C),
        body: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/climature-logo.png',
                width: 200,
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.easeInOut,
              left: _startAnimation ? constraints.maxWidth / 2 : -150,
              top: _startAnimation ? constraints.maxHeight / 2 - 150 : constraints.maxHeight / 2,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.easeInOut,
                width: _startAnimation ? 100 : 250,
                height: _startAnimation ? 100 : 250,
                child: LottieBuilder.asset(
                  'assets/lottie/animation.json',
                  controller: _animationController,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
