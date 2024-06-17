import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants/enum.dart';
import 'package:weather_app/constants/shared_preferences_keys.dart';
import 'package:weather_app/models/weather_card_data.dart';
import 'package:weather_app/respository/weather_repository.dart';
import 'package:weather_app/utils/request_state_with_value.dart';

import '../../../../../models/city.dart';

part 'city_list_state.dart';

class CityListCubit extends Cubit<CityListState> {
  CityListCubit({
    required this.weatherRepository,
  }) : super(const CityListState()) {
    init();
  }

  final WeatherRepository weatherRepository;
  late final SharedPreferences? preferences;

  void init() async {
    preferences = await SharedPreferences.getInstance();

    await getPreferences();
    await Future.wait([fetchFavoriteCityMeta(), fetchFavoritesMeta()]);

    Future.delayed(const Duration(milliseconds: 300), () {
      emit(state.copyWith(isLoading: false));
    });
  }

  Future<void> getPreferences() async {
    await Future.wait([getFavoriteCity(), getFavorites()]);
  }

  Future<void> getFavoriteCity() async {
    final favoriteCity = preferences?.getString(SharedPreferencesKeys.favoriteCity);
    emit(state.copyWith(favoriteCity: favoriteCity));
  }

  Future<void> getFavorites() async {
    final favorites = preferences?.getStringList(SharedPreferencesKeys.favorites) ?? [];
    emit(state.copyWith(favorites: favorites));
  }

  Future<void> searchCity({required String searchQuery}) async {
    emit(state.copyWith(cities: state.cities.copyWith(requestState: RequestState.loading)));

    try {
      final cities = await weatherRepository.searchCities(city: searchQuery);
      emit(state.copyWith(
          cities: state.cities.copyWith(requestState: RequestState.success, value: cities)));
    } catch (e) {
      emit(state.copyWith(cities: state.cities.copyWith(requestState: RequestState.error)));
    }
  }

  Future<void> fetchFavoriteCityMeta() async {
    emit(state.copyWith(
        favoriteCityMeta: state.favoriteCityMeta.copyWith(requestState: RequestState.loading)));

    try {
      final favoriteCityMeta =
          await weatherRepository.getLocationMetaData(city: state.favoriteCity);

      emit(state.copyWith(
          favoriteCityMeta:
              RequestStateWithValue(requestState: RequestState.success, value: favoriteCityMeta)));
    } catch (e) {
      emit(state.copyWith(
          favoriteCityMeta: state.favoriteCityMeta.copyWith(requestState: RequestState.error)));
    }
  }

  Future<void> fetchFavoritesMeta() async {
    emit(state.copyWith(
        favoritesMeta: state.favoritesMeta.copyWith(requestState: RequestState.loading)));

    try {
      final List<Future<WeatherCardData?>> futures = state.favorites.map((city) {
        return weatherRepository.getLocationMetaData(city: city);
      }).toList();

      final List<WeatherCardData?> results = await Future.wait(futures);

      final List<WeatherCardData> favoritesMeta = results.whereType<WeatherCardData>().toList();

      emit(state.copyWith(
        favoritesMeta:
            RequestStateWithValue(requestState: RequestState.success, value: favoritesMeta),
      ));
    } catch (e) {
      emit(state.copyWith(
          favoritesMeta: state.favoritesMeta.copyWith(requestState: RequestState.error)));
    }
  }

  Future<void> updateFavoriteCity({required String city}) async {
    if (city != state.favoriteCity) {
      final List<String> favorites = [state.favoriteCity, ...state.favorites];
      favorites.remove(city);
      emit(state.copyWith(favoriteCity: city, favorites: favorites));

      await _updatePreferences(city, favorites);

      await fetchFavoriteCityMeta();
      await fetchFavoritesMeta();
    }
  }

  Future<void> removeFavoriteCity() async {
    emit(state.copyWith(favoriteCity: '', favoriteCityMeta: null));
  }

  Future<void> removeFromFavorites({required String city}) async {
    final List<String> favorites = List.from(state.favorites)..remove(city);
    emit(state.copyWith(favorites: favorites));

    await preferences?.setStringList(SharedPreferencesKeys.favorites, favorites);

    await fetchFavoritesMeta();
  }

  Future<void> addToFavorites({required String city}) async {
    if (!state.favorites.contains(city) && city != state.favoriteCity) {
      final List<String> favorites = [city, ...state.favorites];
      emit(state.copyWith(favorites: favorites));

      await preferences?.setStringList(SharedPreferencesKeys.favorites, favorites);

      await fetchFavoritesMeta();
    }
  }

  Future<void> _updatePreferences(String city, List<String> favorites) async {
    await preferences?.setString(SharedPreferencesKeys.favoriteCity, city);
    await preferences?.setStringList(SharedPreferencesKeys.favorites, favorites);
  }

  void toggleEditMode() {
    emit(state.copyWith(isEditMode: !state.isEditMode));
  }

  void clearCitiesSearchResults() {
    emit(state.copyWith(cities: state.cities.copyWith(value: [])));
  }
}
