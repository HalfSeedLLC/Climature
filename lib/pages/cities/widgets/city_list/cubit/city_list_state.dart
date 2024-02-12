part of 'city_list_cubit.dart';

class CityListState extends Equatable {
  const CityListState({
    this.favoriteCity = 'Los Angeles',
    this.favorites = const ['New York', 'Memphis', 'London'],
    this.favoritesMeta = const [],
    this.cities = const [],
  });

  final String favoriteCity;
  final List<String> favorites;
  final List<WeatherCardData> favoritesMeta;
  final List<City> cities;

  @override
  List<Object?> get props => [favoriteCity, favorites, favoritesMeta, cities];

  CityListState copyWith({
    String? favoriteCity,
    List<String>? favorites,
    List<WeatherCardData>? favoritesMeta,
    List<City>? cities,
  }) {
    return CityListState(
      favoriteCity: favoriteCity ?? this.favoriteCity,
      favorites: favorites ?? this.favorites,
      favoritesMeta: favoritesMeta ?? this.favoritesMeta,
      cities: cities ?? this.cities,
    );
  }
}
