import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/enum.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/pages/home/widgets/city_list/cubit/city_list_cubit.dart';
import 'package:weather_app/utils/localizations.dart';
import 'package:weather_app/utils/request_state_with_value.dart';

import '../../../../theme/colors.dart';

typedef OnDismissSearchEvent = void Function();

class CityList extends StatelessWidget {
  const CityList({
    required this.isSearchBarFocused,
    required this.onDismissSearchEvent,
    required this.isSearchEmpty,
    Key? key,
  }) : super(key: key);

  final bool isSearchBarFocused;
  final OnDismissSearchEvent onDismissSearchEvent;
  final bool isSearchEmpty;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CityListCubit, CityListState, RequestStateWithValue<List<City>>>(
      selector: (state) => state.cities,
      builder: (context, state) {
        final cities = state.value;
        final requestState = state.requestState;

        return IgnorePointer(
          ignoring: !isSearchBarFocused,
          child: AnimatedOpacity(
            opacity: isSearchBarFocused ? 1 : 0,
            duration: Duration(milliseconds: !isSearchEmpty ? 0 : 700),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: WeatherColors.black.withOpacity(
                  isSearchEmpty ? 0.7 : 1,
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: !isSearchEmpty && cities.isEmpty && requestState == RequestState.success
                    ? Center(
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: WeatherColors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(context.localizations.noCitiesOrAirportsFound),
                            )),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Wrap(
                            runSpacing: 10,
                            children: List.generate(
                              cities.length,
                              (i) => TextButton(
                                onPressed: () async {
                                  Future.wait([
                                    context
                                        .read<CityListCubit>()
                                        .addToFavorites(city: cities.elementAt(i).name),
                                    HapticFeedback.mediumImpact()
                                  ]);

                                  onDismissSearchEvent.call();
                                },
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: i == 0 ? WeatherColors.ev1 : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          '${cities.elementAt(i).name}, ${cities.elementAt(i).region} ${cities.elementAt(i).country}',
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
