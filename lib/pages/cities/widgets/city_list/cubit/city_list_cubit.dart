import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/models/weather_card_data.dart';
import 'package:weather_app/respository/weather_repository.dart';
import 'package:weather_app/storage/hive.dart';

import '../../../../../models/city.dart';

part 'city_list_state.dart';

class CityListCubit extends Cubit<CityListState> {
  CityListCubit({
    required this.weatherRepository,
  }) : super(const CityListState()) {
    init();
  }

  final WeatherRepository weatherRepository;
  Box<dynamic>? box;

  void init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    box = await Hive.openBox<User>('userData');

    await fetchFavoritesMeta();
  }

  Future<void> getCity({required String searchQuery}) async {
    final cities = await weatherRepository.searchCities(city: searchQuery);

    emit(state.copyWith(cities: cities));
  }

  Future<void> fetchFavoritesMeta() async {
    final List<WeatherCardData> favoritesMeta = [];

    for (int i = 0; i < state.favorites.length; i++) {
      final metaData = await weatherRepository.getLocationMetaData(
          city: state.favorites.elementAt(i));

      if (metaData != null) {
        favoritesMeta.add(metaData);
      }

      Future.delayed(const Duration(milliseconds: 700), () {
        emit(state.copyWith(isLoading: false));
      });
    }

    emit(state.copyWith(favoritesMeta: favoritesMeta));
  }

  Future<void> addToFavorites({required String city}) async {
    final favorites = [city] + state.favorites;
    emit(state.copyWith(favorites: favorites));

    final userData = User('Fresno', favorites);
    userData.save();

    await fetchFavoritesMeta();
  }
}
