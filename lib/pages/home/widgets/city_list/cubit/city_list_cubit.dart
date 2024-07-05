import 'package:climature/constants/enum.dart';
import 'package:climature/constants/shared_preferences_keys.dart';
import 'package:climature/models/weather_card_data.dart';
import 'package:climature/objectbox.g.dart';
import 'package:climature/respository/weather_repository.dart';
import 'package:climature/utils/request_state_with_value.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    await getFavoritesFromDatabase();
    await getFavoriteCityPreference();
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

    final List<String> defaultsToLoad = await defaultCitiesToLoad();
    final List<String> favorites = [...state.favorites, ...defaultsToLoad];

    try {
      final List<Future<WeatherCardData?>> futures = favorites.map((city) {
        return weatherRepository.getLocationMetaData(city: city);
      }).toList();

      final List<WeatherCardData?> results = await Future.wait(futures);

      final List<WeatherCardData> favoritesData = results.whereType<WeatherCardData>().toList();

      emit(state.copyWith(
        favorites: defaultsToLoad,
        favoritesData:
            RequestStateWithValue(requestState: RequestState.success, value: favoritesData),
      ));
    } catch (e) {
      emit(state.copyWith(
          favoritesData: state.favoritesData.copyWith(requestState: RequestState.error)));
    }
  }

  Future<List<String>> defaultCitiesToLoad() async {
    List<String> defaultCitiesToLoad = [defaultFavoriteCity, ...defaultCities];

    final removedDefaultCities =
        preferences?.getStringList(SharedPreferencesKeys.removedDefaultCities);

    if (removedDefaultCities != null) {
      defaultCitiesToLoad =
          defaultCitiesToLoad.where((city) => !removedDefaultCities.contains(city)).toList();
    }

    return defaultCitiesToLoad;
  }

  Future<void> _removeCityIfDefault({required String city}) async {
    final allDefaultCities = [defaultFavoriteCity, ...defaultCities];

    if (allDefaultCities.contains(city)) {
      final removedCities = preferences?.getStringList(SharedPreferencesKeys.removedDefaultCities);

      await preferences?.setStringList(
          SharedPreferencesKeys.removedDefaultCities, [city, ...removedCities ?? []]);
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

    _removeCityIfDefault(city: state.favoriteCity);

    emit(state.copyWith(
        favoriteCity: '',
        favorites: state.favorites.where((e) => e != state.favoriteCity).toList(),
        favoritesData: state.favoritesData.copyWith(
            value: state.favoritesData.value
                .where((e) => e.location.name != state.favoriteCity)
                .toList())));

    removeCityFromDatabase(city: favoriteCity);
  }

  Future<void> removeFromFavorites({required String city}) async {
    final List<String> favorites = state.favorites.where((e) => e != city).toList();
    final List<WeatherCardData> favoritesData =
        state.favoritesData.value.where((e) => e.location.name != city).toList();

    await _removeCityIfDefault(city: city);

    emit(state.copyWith(
        favorites: favorites, favoritesData: state.favoritesData.copyWith(value: favoritesData)));

    removeCityFromDatabase(city: city);
  }

  Future<void> removeCityFromDatabase({required String city}) async {
    Query<db_city.City> query = cityBox.query(City_.name.equals(city)).build();
    db_city.City? existingCity = query.findFirst();

    if (existingCity != null) {
      cityBox.remove(existingCity.id);
    }
  }

  Future<void> addToFavorites({required String city}) async {
    if (!state.favorites.contains(city) && city != state.favoriteCity) {
      final cityData = await weatherRepository.getLocationMetaData(city: city);

      if (cityData != null) {
        final List<String> favorites = [city, ...state.favorites];
        final List<WeatherCardData> favoritesData = [cityData, ...state.favoritesData.value];
        emit(state.copyWith(
            favorites: favorites,
            favoritesData: state.favoritesData.copyWith(value: favoritesData)));

        final db_city.City newCity = db_city.City(name: city);
        cityBox.put(newCity);
      }
    }
  }

  void toggleEditMode() {
    emit(state.copyWith(isEditMode: !state.isEditMode));
  }

  void clearCitiesSearchResults() {
    emit(state.copyWith(cities: state.cities.copyWith(value: [])));
  }
}
