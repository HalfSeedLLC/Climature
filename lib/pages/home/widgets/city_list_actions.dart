import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/pages/home/widgets/city_list/cubit/city_list_cubit.dart';

import '../../../theme/colors.dart';
import '../../../widgets/action_button.dart';

class CityListActions extends StatelessWidget {
  const CityListActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        child: Container(
          color: WeatherColors.ev1,
          height: 200,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Wrap(
                runSpacing: 20,
                children: [
                  ActionButton(
                    title: 'EDIT FAVORITES',
                    color: WeatherColors.black,
                    backgroundColor: WeatherColors.white,
                    onPressed: () {
                      context.read<CityListCubit>().toggleEditMode();
                      Navigator.pop(context);
                    },
                  ),
                  ActionButton(
                    title: 'REORDER',
                    color: WeatherColors.white,
                    borderColor: WeatherColors.white,
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
