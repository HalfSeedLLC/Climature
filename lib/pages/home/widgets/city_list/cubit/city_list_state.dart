part of 'city_list_cubit.dart';

class CityListState extends Equatable {
  const CityListState({
    this.favoriteCity = 'Los Angeles',
    this.favoriteCityMeta =
        const RequestStateWithValue(requestState: RequestState.initial, value: null),
    this.favorites = const ['New York', 'Memphis', 'London'],
    this.favoritesMeta = const RequestStateWithValue(requestState: RequestState.initial, value: []),
    this.cities = const RequestStateWithValue(requestState: RequestState.initial, value: []),
    this.isEditMode = false,
    this.isReorderMode = false,
    this.isLoading = true,
  });

  final String favoriteCity;
  final RequestStateWithValue<WeatherCardData?> favoriteCityMeta;
  final List<String> favorites;
  final RequestStateWithValue<List<WeatherCardData>> favoritesMeta;
  final RequestStateWithValue<List<City>> cities;
  final bool isEditMode;
  final bool isReorderMode;
  final bool isLoading;

  @override
  List<Object?> get props => [
        favoriteCity,
        favoriteCityMeta,
        favorites,
        favoritesMeta,
        cities,
        isReorderMode,
        isEditMode,
        isLoading
      ];

  CityListState copyWith({
    String? favoriteCity,
    RequestStateWithValue<WeatherCardData?>? favoriteCityMeta,
    List<String>? favorites,
    RequestStateWithValue<List<WeatherCardData>>? favoritesMeta,
    RequestStateWithValue<List<City>>? cities,
    bool? isEditMode,
    bool? isReorderMode,
    bool? isLoading,
  }) {
    return CityListState(
      favoriteCity: favoriteCity ?? this.favoriteCity,
      favoriteCityMeta: favoriteCityMeta ?? this.favoriteCityMeta,
      favorites: favorites ?? this.favorites,
      favoritesMeta: favoritesMeta ?? this.favoritesMeta,
      cities: cities ?? this.cities,
      isEditMode: isEditMode ?? this.isEditMode,
      isReorderMode: isReorderMode ?? this.isReorderMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
