import 'package:flutter/material.dart';

class WeatherModel {
  DateTime date;
  double temp;
  double mintemp;
  double maxtemp;
  String weatherStateName;
  WeatherModel({
    required this.mintemp,
    required this.maxtemp,
    required this.weatherStateName,
    required this.date,
    required this.temp,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> data) {
  var forecastDay = data['forecast']['forecastday'][0]['day'];
  var location = data['location'];
  var current = data['current'];

  return WeatherModel(
    mintemp: forecastDay["mintemp_c"]?.toDouble() ?? 0.0,
    maxtemp: forecastDay["maxtemp_c"]?.toDouble() ?? 0.0,
    temp: current["temp_c"]?.toDouble() ?? 0.0, // حرارة حالية
    weatherStateName: current["condition"]["text"], // زي Sunny, Rainy...
    date: DateTime.parse(location['localtime']), // تحويل String لـ DateTime
  );
}

  String getImage() {
  if (weatherStateName.contains('Sunny') || weatherStateName.contains('Clear')) {
    return 'assets/images/clear.png';
  } else if (weatherStateName.contains('Snow')) {
    return 'assets/images/snow.png';
  } else if (weatherStateName.contains('cloud')) {
    return 'assets/images/cloudy.png';
  } else if (weatherStateName.contains('rain') || weatherStateName.contains('Rain')) {
    return 'assets/images/rainy.png';
  } else if (weatherStateName.contains('thunder')) {
    return 'assets/images/thunderstorm.png';
  } else {
    return 'assets/images/clear.png';
  }
}

MaterialColor getThemeColor() {
  String state = weatherStateName.toLowerCase();

  if (state.contains('sunny') || state.contains('clear')) {
    return Colors.orange; // الجو صافي / مشمس
  } else if (state.contains('snow') || state.contains('blizzard') || state.contains('sleet')) {
    return Colors.blue; // التلج
  } else if (state.contains('cloud') || state.contains('overcast')) {
    return Colors.blueGrey; // غيوم
  } else if (state.contains('rain') || state.contains('shower') || state.contains('drizzle')) {
    return Colors.indigo; // مطر
  } else if (state.contains('thunder')) {
    return Colors.deepPurple; // عواصف رعدية
  } else {
    return Colors.teal; // أي حاجة تانية default
  }
}

  @override
  String toString() {
    // TODO: implement toString
    return 'temp=$temp mintemp=$mintemp date=$date';
  }
}
