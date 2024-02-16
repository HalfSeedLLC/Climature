import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/shared_preferences_keys.dart';
import 'package:weather_app/models/weather_card_data.dart';
import 'package:weather_app/respository/weather_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    Future.wait([fetchFavoriteCityMeta(), fetchFavoritesMeta()]);
  }

  Future<void> getPreferences() async {
    await Future.wait([getFavoriteCity(), getFavorites()]);
  }

  Future<void> getFavoriteCity() async {
    final favoriteCity =
        preferences?.getString(SharedPreferencesKeys.favoriteCity);

    emit(state.copyWith(favoriteCity: favoriteCity));
  }

  Future<void> getFavorites() async {
    final favorites =
        preferences?.getStringList(SharedPreferencesKeys.favorites);

    emit(state.copyWith(favorites: favorites));
  }

  Future<void> searchCity({required String searchQuery}) async {
    final cities = await weatherRepository.searchCities(city: searchQuery);

    emit(state.copyWith(cities: cities));
  }

  Future<void> fetchFavoriteCityMeta() async {
    if (state.favoriteCity.isNotEmpty) {
      final favoriteCityMeta =
          await weatherRepository.getLocationMetaData(city: state.favoriteCity);

      emit(state.copyWith(favoriteCityMeta: favoriteCityMeta));
    }
  }

  Future<void> fetchFavoritesMeta() async {
    final List<WeatherCardData> favoritesMeta = [];

    for (int i = 0; i < state.favorites.length; i++) {
      final metaData = await weatherRepository.getLocationMetaData(
          city: state.favorites.elementAt(i));

      if (metaData != null) {
        favoritesMeta.add(metaData);
      }
    }

    emit(state.copyWith(favoritesMeta: favoritesMeta));

    Future.delayed(const Duration(milliseconds: 700), () {
      emit(state.copyWith(isLoading: false));
    });
  }

  Future<void> updateFavoriteCity({required String city}) async {
    if (city != state.favoriteCity) {
      final favorites = [state.favoriteCity] + state.favorites;
      favorites.remove(city);
      emit(state.copyWith(favoriteCity: city, favorites: favorites));

      preferences?.setString(SharedPreferencesKeys.favoriteCity, city);
      preferences?.setStringList(SharedPreferencesKeys.favorites, favorites);

      fetchFavoriteCityMeta();
      fetchFavoritesMeta();
    }
  }

  Future<void> removeFavoriteCity() async {
    emit(state.copyWith(favoriteCity: ''));
    emit(state.copyWith(favoriteCityMeta: null));
  }

  Future<void> removeFromFavorites({required String city}) async {
    final favorites = state.favorites;
    favorites.remove(city);
    fetchFavoritesMeta();

    preferences?.setStringList(SharedPreferencesKeys.favorites, favorites);

    emit(state.copyWith(favorites: favorites));
  }

  Future<void> addToFavorites({required String city}) async {
    if (!state.favorites.contains(city) && city != state.favoriteCity) {
      final favorites = [city] + state.favorites;
      emit(state.copyWith(favorites: favorites));

      await preferences?.setStringList(
          SharedPreferencesKeys.favorites, favorites);

      await fetchFavoritesMeta();
    }
  }

  void toggleEditMode() {
    emit(state.copyWith(isEditMode: !state.isEditMode));
  }
}
