import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/main.dart' as app;
import 'package:weather_app/pages/home/home.dart';
import 'package:weather_app/pages/home/widgets/action_icon.dart';
import 'package:weather_app/pages/home/widgets/city_list/city_list.dart';
import 'package:weather_app/pages/home/widgets/home_header.dart';
import 'package:weather_app/pages/home/widgets/home_search_bar.dart';
import 'package:weather_app/pages/landing/landing.dart';
import 'package:weather_app/utils/localizations.dart';
import 'package:weather_app/widgets/action_button.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  Future<void> landingViewTesting(WidgetTester tester) async {
    await tester.pump(const Duration(seconds: 4));
    final BuildContext context = tester.element(find.byType(Landing));

    expect(find.byType(Landing), findsOneWidget);
    expect(find.text(context.localizations.trusted.toUpperCase()), findsOneWidget);
    expect(find.text(context.localizations.weather.toUpperCase()), findsOneWidget);
    expect(find.text(context.localizations.forecast.toUpperCase()), findsOneWidget);

    expect(find.byType(ActionButton), findsOneWidget);
    expect(find.text(context.localizations.getStarted.toUpperCase()), findsOneWidget);
    await tester.tap(find.text(context.localizations.getStarted.toUpperCase()));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(Home), findsOneWidget);
  }

  Future<void> homeViewTesting(WidgetTester tester) async {
    await tester.pump(const Duration(seconds: 4));
    final BuildContext context = tester.element(find.byType(Home));

    expect(find.byType(Home), findsOneWidget);
    expect(find.byType(HomeHeader), findsOneWidget);
    expect(find.byType(HomeSearchBar), findsOneWidget);

    expect(find.text(context.localizations.cityList), findsOneWidget);
    expect(find.text(context.localizations.yourCity), findsOneWidget);
    expect(find.text(context.localizations.yourFavorites), findsOneWidget);

    expect(find.byType(CityList), findsOneWidget);

    await tester.tap(find.byType(HomeSearchBar));
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.text(context.localizations.cancel));
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.byType(HomeSearchBar));
    await tester.pump(const Duration(seconds: 2));

    await tester.enterText(find.byType(TextField), 'Fresno');
    await tester.pump(const Duration(seconds: 4));

    await tester.tap(find.text('Fresno, California United States of America'));
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.byType(HomeSearchBar));
    await tester.pump(const Duration(seconds: 2));

    await tester.enterText(find.byType(TextField), 'Clovis');
    await tester.pump(const Duration(seconds: 3));

    await tester.tap(find.text('Clovis, California United States of America'));
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.byIcon(Icons.pending_outlined));
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(find.byIcon(Icons.cancel_outlined));
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.byIcon(Icons.pending_outlined));
    await tester.pump(const Duration(seconds: 2));

    final actionIcons = find.byType(ActionIcon);
    await tester.tap(actionIcons.at(4));
    await tester.pump(const Duration(seconds: 3));

    await tester.tap(find.byIcon(Icons.cancel_outlined));
    await tester.pump(const Duration(seconds: 3));

    await tester.tap(find.byIcon(Icons.pending_outlined));
    await tester.pump(const Duration(seconds: 2));

    await tester.tap(actionIcons.at(3));
  }

  testWidgets('End to end test', (WidgetTester tester) async {
    app.main();
    await landingViewTesting(tester);
    await homeViewTesting(tester);
  });
}
