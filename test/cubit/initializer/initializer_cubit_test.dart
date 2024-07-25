import 'package:bloc_test/bloc_test.dart';
import 'package:climature/constants/enum.dart';
import 'package:climature/constants/shared_preferences_keys.dart';
import 'package:climature/logic/initializer_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(const InitializerState());
  });

  group('InitializerCubit', () {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKeys.isFirstLoad: true,
    });

    blocTest<InitializerCubit, InitializerState>(
      'initial state',
      build: () => InitializerCubit(),
      skip: 1,
      expect: () => [
        const InitializerState(requestState: RequestState.success, isFirstLoad: true),
      ],
    );
  });
}
