import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants/enum.dart';
import 'package:weather_app/constants/shared_preferences_keys.dart';
import 'package:weather_app/models/weather_card_data.dart';
import 'package:weather_app/objectbox.g.dart';
import 'package:weather_app/respository/weather_repository.dart';
import 'package:weather_app/utils/request_state_with_value.dart';

import '../../../../../models/city.dart';
import '../../../../../models/database/city.dart' as db_city;

part 'city_list_state.dart';

class CityListCubit extends Cubit<CityListState> {
  CityListCubit({
    required this.weatherRepository,
  }) : super(const CityListState()) {
    init();
  }

  final WeatherRepository weatherRepository;
  late final SharedPreferences? preferences;
  late final Box<db_city.City> cityBox;

  void init() async {
    preferences = await SharedPreferences.getInstance();
    cityBox = weatherRepository.database.store.box<db_city.City>();

    await _fetchPreferences();
    await Future.wait([fetchFavorites()]);

    Future.delayed(const Duration(milliseconds: 300), () {
      emit(state.copyWith(isLoading: false));
    });
  }

  Future<void> _fetchPreferences() async {
    await getFavoriteCityPreference();
    await getFavoritesFromDatabase();
  }

  Future<void> getFavoriteCityPreference() async {
    final favoriteCity = preferences?.getString(SharedPreferencesKeys.favoriteCity);
    emit(state.copyWith(favoriteCity: favoriteCity));
  }

  Future<void> getFavoritesFromDatabase() async {
    final cities = cityBox.getAll();

    final List<String> favorites = cities.map((city) => city.name!).toList();

    emit(state.copyWith(favorites: favorites));
  }

  Future<void> fetchFavorites() async {
    emit(state.copyWith(
        favoritesData: state.favoritesData.copyWith(requestState: RequestState.loading)));

    try {
      final List<Future<WeatherCardData?>> futures = state.favorites.map((city) {
        return weatherRepository.getLocationMetaData(city: city);
      }).toList();

      final List<WeatherCardData?> results = await Future.wait(futures);

      final List<WeatherCardData> favoritesData = results.whereType<WeatherCardData>().toList();

      emit(state.copyWith(
        favoritesData:
            RequestStateWithValue(requestState: RequestState.success, value: favoritesData),
      ));
    } catch (e) {
      emit(state.copyWith(
          favoritesData: state.favoritesData.copyWith(requestState: RequestState.error)));
    }
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

  Future<void> updateFavoriteCity({required String city}) async {
    if (city != state.favoriteCity) {
      await preferences?.setString(SharedPreferencesKeys.favoriteCity, city);
      emit(state.copyWith(favoriteCity: city));
    }
  }

  Future<void> removeFavoriteCity() async {
    final favoriteCity = state.favoriteCity;

    emit(state.copyWith(
        favoriteCity: '',
        favorites: state.favorites.where((e) => e != state.favoriteCity).toList(),
        favoritesData: state.favoritesData.copyWith(
            value: state.favoritesData.value
                .where((e) => e.location.name != state.favoriteCity)
                .toList())));

    _removeCityFromDatabase(city: favoriteCity);
  }

  Future<void> removeFromFavorites({required String city}) async {
    final List<String> favorites = state.favorites.where((e) => e != city).toList();
    final List<WeatherCardData> favoritesData =
        state.favoritesData.value.where((e) => e.location.name != city).toList();

    emit(state.copyWith(
        favorites: favorites, favoritesData: state.favoritesData.copyWith(value: favoritesData)));

    _removeCityFromDatabase(city: city);
  }

  Future<void> _removeCityFromDatabase({required String city}) async {
    Query<db_city.City> query = cityBox.query(City_.name.equals(city)).build();
    db_city.City? existingCity = query.findFirst();

    if (existingCity != null) {
      cityBox.remove(existingCity.id);
    }
  }

  Future<void> addToFavorites({required String city}) async {
    if (!state.favorites.contains(city) && city != state.favoriteCity) {
      final List<String> favorites = [city, ...state.favorites];
      emit(state.copyWith(favorites: favorites));

      final db_city.City newCity = db_city.City(name: city);
      cityBox.put(newCity);

      await fetchFavorites();
    }
  }

  void toggleEditMode() {
    emit(state.copyWith(isEditMode: !state.isEditMode));
  }

  void clearCitiesSearchResults() {
    emit(state.copyWith(cities: state.cities.copyWith(value: [])));
  }
}
