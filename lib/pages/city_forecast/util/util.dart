double calculateSunPosition(String timeString) {
  try {
    final List<String> parts = timeString.split(' ');

    final List<String> dateParts = parts[0].split('-');
    final int year = int.parse(dateParts[0]);
    final int month = int.parse(dateParts[1]);
    final int day = int.parse(dateParts[2]);

    final List<String> timeParts = parts[1].split(':');
    final int hour = int.parse(timeParts[0]);
    final int minute = int.parse(timeParts[1]);

    final DateTime dateTime = DateTime(year, month, day, hour, minute);
    final DateTime midnight =
        DateTime(dateTime.year, dateTime.month, dateTime.day);
    final int totalMinutes = dateTime.difference(midnight).inMinutes;

    return totalMinutes / 1440.0;
  } catch (err) {
    return 0;
  }
}

String getUVMessage({required double uv}) {
  if (uv <= 3) {
    return 'You can safely enjoy being outside';
  } else if (uv <= 5) {
    return 'Take precaution during midday hours';
  } else if (uv <= 7) {
    return 'Protection against sun damage needed';
  } else if (uv <= 10) {
    return 'Reduce sun exposure 10AM - 4PM';
  }
  return 'Reduce sun exposure 10AM - 4PM';
}

int calculatePM25AQI(double concentration) {
  final List<double> pm25ConcentrationRanges = [
    0.0,
    12.1,
    35.5,
    55.5,
    150.5,
    250.5,
    350.5
  ];
  final List<int> pm25AQIRanges = [0, 51, 101, 151, 201, 301, 401, 501];

  int index = 0;
  while (index < pm25ConcentrationRanges.length - 1 &&
      concentration > pm25ConcentrationRanges[index + 1]) {
    index++;
  }

  double lowerConcentration = pm25ConcentrationRanges[index];
  double upperConcentration = pm25ConcentrationRanges[index + 1];
  int lowerAQI = pm25AQIRanges[index];
  int upperAQI = pm25AQIRanges[index + 1];

  double aqi = ((upperAQI - lowerAQI) *
          (concentration - lowerConcentration) /
          (upperConcentration - lowerConcentration)) +
      lowerAQI;
  return aqi.toInt();
}

String getAQICategory(int aqiValue) {
  if (aqiValue >= 0 && aqiValue <= 50) {
    return "Good";
  } else if (aqiValue >= 51 && aqiValue <= 100) {
    return "Moderate";
  } else if (aqiValue >= 101 && aqiValue <= 150) {
    return "Unhealthy for Sensitive Groups";
  } else if (aqiValue >= 151 && aqiValue <= 200) {
    return "Unhealthy";
  } else if (aqiValue >= 201 && aqiValue <= 300) {
    return "Very Unhealthy";
  } else if (aqiValue >= 301) {
    return "Hazardous";
  } else {
    return "Invalid AQI value";
  }
}

String getAQIMessage(int aqiValue) {
  if (aqiValue >= 0 && aqiValue <= 50) {
    return "Air quality is good. It's a great day to be outside.";
  } else if (aqiValue >= 51 && aqiValue <= 100) {
    return "Air quality is acceptable. Consider making outdoor activities shorter and less intense.";
  } else if (aqiValue >= 101 && aqiValue <= 150) {
    return "Sensitive groups: Make outdoor activities shorter and less intense. Take more breaks.";
  } else if (aqiValue >= 151 && aqiValue <= 200) {
    return "Sensitive groups: Avoid long or intense outdoor activities. Consider rescheduling or moving activities indoors. Reduce long or intense outdoor activities. Take more breaks.";
  } else if (aqiValue >= 201 && aqiValue <= 300) {
    return "Sensitive groups: Avoid all physical activity outdoors. Reschedule or move activities indoors. Avoid long or intense outdoor activities. Consider rescheduling or moving activities indoors.";
  } else if (aqiValue >= 301) {
    return "Everyone: Avoid all outdoor physical activities. Keep activity levels low at home.";
  } else {
    return "Invalid AQI value";
  }
}

String getWeatherDescription(int visibilityMiles) {
  if (visibilityMiles >= 10) {
    return "It's perfectly clear right now";
  } else if (visibilityMiles >= 6 && visibilityMiles < 10) {
    return "It's clear right now";
  } else if (visibilityMiles >= 3 && visibilityMiles < 6) {
    return "It's fair right now";
  } else if (visibilityMiles >= 1 && visibilityMiles < 3) {
    return "It's hazy right now";
  } else if (visibilityMiles < 1) {
    return "It's foggy right now";
  } else {
    return "Unknown weather condition";
  }
}
