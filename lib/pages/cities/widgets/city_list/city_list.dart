import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/pages/cities/widgets/city_list/cubit/city_list_cubit.dart';

import '../../../../theme/colors.dart';

typedef OnDismissSearch = void Function();

class CityList extends StatelessWidget {
  const CityList({
    required this.searchQuery,
    required this.isSearchBarFocused,
    required this.textController,
    required this.onDismissSearch,
    Key? key,
  }) : super(key: key);

  final String searchQuery;
  final bool isSearchBarFocused;
  final TextEditingController textController;
  final OnDismissSearch onDismissSearch;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityListCubit, CityListState>(
      builder: (context, state) {
        return IgnorePointer(
          ignoring: !isSearchBarFocused,
          child: AnimatedOpacity(
            opacity: isSearchBarFocused ? 1 : 0,
            duration: Duration(milliseconds: searchQuery.isNotEmpty ? 0 : 700),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: WeatherColors.black.withOpacity(
                  textController.text.isEmpty ? 0.7 : 1,
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: textController.text.isNotEmpty
                    ? SingleChildScrollView(
                        child: state.cities.isEmpty
                            ? const Center(
                                child: Text('No cities or airports found'),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Wrap(
                                    runSpacing: 10,
                                    children: List.generate(
                                        state.cities.length,
                                        (i) => TextButton(
                                              onPressed: () async {
                                                Future.wait([
                                                  context
                                                      .read<CityListCubit>()
                                                      .addToFavorites(
                                                          city: state.cities
                                                              .elementAt(i)
                                                              .name),
                                                  HapticFeedback.mediumImpact()
                                                ]);

                                                onDismissSearch.call();
                                              },
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: i == 0
                                                      ? WeatherColors.ev1
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Text(
                                                        '${state.cities.elementAt(i).name}, ${state.cities.elementAt(i).region} ${state.cities.elementAt(i).country}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ))),
                              ),
                      )
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
