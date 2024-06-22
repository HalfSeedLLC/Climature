part of 'city_list_cubit.dart';

const defaultFavoriteCity = 'Los Angeles';

const defaultCities = ['New York', 'Miami', 'Dallas', 'Seattle'];

class CityListState extends Equatable {
  const CityListState({
    this.favoriteCity = defaultFavoriteCity,
    this.favorites = const [...defaultCities],
    this.favoritesData = const RequestStateWithValue(requestState: RequestState.initial, value: []),
    this.cities = const RequestStateWithValue(requestState: RequestState.initial, value: []),
    this.isEditMode = false,
    this.isReorderMode = false,
    this.isLoading = true,
  });

  final String favoriteCity;
  final List<String> favorites;
  final RequestStateWithValue<List<WeatherCardData>> favoritesData;
  final RequestStateWithValue<List<City>> cities;
  final bool isEditMode;
  final bool isReorderMode;
  final bool isLoading;

  @override
  List<Object?> get props =>
      [favoriteCity, favorites, favoritesData, cities, isReorderMode, isEditMode, isLoading];

  CityListState copyWith({
    String? favoriteCity,
    List<String>? favorites,
    RequestStateWithValue<List<WeatherCardData>>? favoritesData,
    RequestStateWithValue<List<City>>? cities,
    bool? isEditMode,
    bool? isReorderMode,
    bool? isLoading,
  }) {
    return CityListState(
      favoriteCity: favoriteCity ?? this.favoriteCity,
      favorites: favorites ?? this.favorites,
      favoritesData: favoritesData ?? this.favoritesData,
      cities: cities ?? this.cities,
      isEditMode: isEditMode ?? this.isEditMode,
      isReorderMode: isReorderMode ?? this.isReorderMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
