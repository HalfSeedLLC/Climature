String getDayOfWeekString({required String date}) {
  DateTime currentDate = DateTime.now();
  DateTime inputDate = DateTime.parse(date);

  if (currentDate.year == inputDate.year &&
      currentDate.month == inputDate.month &&
      currentDate.day == inputDate.day) {
    return 'Today';
  } else {
    List<String> dayNames = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    int inputDayOfWeek = inputDate.weekday;
    return dayNames[inputDayOfWeek - 1];
  }
}

String getAirQualityMessage({required int? usEpaIndex}) {
  switch (usEpaIndex) {
    case 1:
      return 'Good';
    case 2:
      return 'Moderate';
    case 3:
      return 'Unhealthy for sensitive groups';
    case 4:
      return 'Unhealthy';
    case 5:
      return 'Very Unhealthy';
    case 6:
      return 'Hazardous';
    default:
      return '';
  }
}

String getWeatherIconAsset({required String iconAsset}) {
  if (iconAsset.isNotEmpty) {
    int lastIndex = iconAsset.lastIndexOf('/');
    int secondToLastIndex = iconAsset.lastIndexOf('/', lastIndex - 1);
    if (secondToLastIndex != -1) {
      return 'assets/weather/icons/${iconAsset.substring(secondToLastIndex + 1)}';
    }
  }
  return iconAsset;
}
