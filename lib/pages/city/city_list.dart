import 'package:flutter/material.dart';
import 'package:weather_app/pages/city/city.dart';

class CityList extends StatefulWidget {
  const CityList({
    Key? key,
  }) : super(key: key);

  static const route = '/city_list';

  @override
  State<CityList> createState() => _CityList();
}

class _CityList extends State<CityList> {
  @override
  Widget build(BuildContext context) => const City();
}
