import 'package:climature/theme/colors.dart';
import 'package:climature/utils/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'city_list/cubit/city_list_cubit.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.currentCondition,
    required this.isSearchBarFocused,
    required this.isEditMode,
    Key? key,
  }) : super(key: key);

  final String currentCondition;
  final bool isSearchBarFocused;
  final bool isEditMode;

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, constraints) {
        return AnimatedContainer(
          height: isSearchBarFocused ? 0 : 60,
          duration: const Duration(milliseconds: 250),
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.localizations.cityList,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: constraints.maxWidth - 50,
                      child: Text(
                        currentCondition.isEmpty
                            ? context.localizations.addYourCityMessage
                            : context.localizations.currentConditions(currentCondition),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    context.read<CityListCubit>().toggleEditMode();
                    HapticFeedback.mediumImpact();
                  },
                  child: isEditMode
                      ? const Icon(size: 30, Icons.cancel_outlined, color: WeatherColors.white)
                      : const Icon(size: 30, Icons.pending_outlined, color: WeatherColors.white),
                )
              ],
            ),
          ),
        );
      });
}
