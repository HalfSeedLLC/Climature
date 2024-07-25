import 'package:climature/constants/enum.dart';
import 'package:climature/logic/initializer_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InitializerState', () {
    test('has correct initial values', () {
      const state = InitializerState();

      expect(state.isFirstLoad, false);
      expect(state.requestState, RequestState.initial);
    });

    test('copyWith returns new instance with updated values', () {
      const state = InitializerState(
        isFirstLoad: true,
        requestState: RequestState.loading,
      );

      final newState = state.copyWith(
        isFirstLoad: false,
        requestState: RequestState.success,
      );

      expect(newState.isFirstLoad, false);
      expect(newState.requestState, RequestState.success);
      expect(newState, isNot(state));
    });

    test('copyWith retains old value for null parameters', () {
      const state = InitializerState(
        isFirstLoad: true,
        requestState: RequestState.loading,
      );

      final newState = state.copyWith();

      expect(newState.isFirstLoad, state.isFirstLoad);
      expect(newState.requestState, state.requestState);
    });

    test('props are correct', () {
      const state = InitializerState(
        isFirstLoad: true,
        requestState: RequestState.success,
      );

      expect(state.props, [true, RequestState.success]);
    });
  });
}
