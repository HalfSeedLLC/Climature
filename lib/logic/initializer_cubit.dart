import 'package:climature/constants/enum.dart';
import 'package:climature/constants/shared_preferences_keys.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'initializer_state.dart';

class InitializerCubit extends Cubit<InitializerState> {
  InitializerCubit() : super(const InitializerState()) {
    _initialize();
  }

  late SharedPreferences _preferences;

  void _initialize() async {
    emit(state.copyWith(requestState: RequestState.loading));
    try {
      await _getIsFirstLoad();
      emit(state.copyWith(requestState: RequestState.success));
    } catch (e) {
      emit(state.copyWith(requestState: RequestState.error));
    }
  }

  Future<void> _getIsFirstLoad() async {
    _preferences = await SharedPreferences.getInstance();
    final isFirstLoad = _preferences.getBool(SharedPreferencesKeys.isFirstLoad) ?? true;
    emit(state.copyWith(isFirstLoad: isFirstLoad));
  }

  Future<void> setIsFirstLoad({required bool isFirstLoad}) async {
    await _preferences.setBool(SharedPreferencesKeys.isFirstLoad, isFirstLoad);
  }
}
