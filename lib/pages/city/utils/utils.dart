List<String> getDayOfWeekStrings() {
  DateTime currentDate = DateTime.now();

  List<String> dayNames = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  int currentDayOfWeek = currentDate.weekday;
  int tomorrowIndex = (currentDayOfWeek + 1) % 7;
  int dayAfterTomorrowIndex = (currentDayOfWeek + 2) % 7;

  String tomorrow = dayNames[tomorrowIndex];
  String dayAfterTomorrow = dayNames[dayAfterTomorrowIndex];

  return ['Today', tomorrow, dayAfterTomorrow];
}
