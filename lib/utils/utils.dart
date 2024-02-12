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

String getUserFriendlyHour({required String dateTime}) {
  List<String> parts = dateTime.split(' ');

  String time = parts[1];

  List<String> timeParts = time.split(':');
  int hour = int.parse(timeParts[0]);

  String hourString = hourOf12HourFormat(hour);

  String period = hour >= 12 ? 'PM' : 'AM';

  return '$hourString$period';
}

String hourOf12HourFormat(int hour) {
  // Convert hour to 12-hour format
  if (hour == 0) {
    return '12';
  } else if (hour <= 12) {
    return hour.toString();
  } else {
    return (hour - 12).toString();
  }
}

String getUserFriendlyTime({required String dateTime}) {
  List<String> parts = dateTime.split(' ');

  String time = parts[1];

  List<String> timeParts = time.split(':');
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1]);

  String hourString = hourOf12HourFormat(hour);

  String period = hour >= 12 ? 'PM' : 'AM';

  return '$hourString:$minute $period';
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
