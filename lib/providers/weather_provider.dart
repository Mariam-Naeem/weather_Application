import 'package:flutter/material.dart';
import 'package:weather_Application/models/weather_model.dart';


class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weatherdata;
  String? cityname;
  set weatherdata(WeatherModel? weather) {
    _weatherdata = weather;
    notifyListeners();
  }

  WeatherModel? get weatherdata => _weatherdata;
}
