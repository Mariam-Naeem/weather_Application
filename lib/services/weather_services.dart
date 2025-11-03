import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_Application/models/weather_model.dart';
 //ادي اسم لكل حاجة جايه من اللينك دا

class WeatherService {
  String baseUri = 'http://api.weatherapi.com/v1';
  String apikey = '414f69f8fb224de6be0233455250409';

  Future<WeatherModel?> getWeather({required String cityname}) async {
  try {
    Uri uri = Uri.parse(
      "$baseUri/forecast.json?key=$apikey&q=$cityname&days=7",
    );
    http.Response response = await http.get(uri);

    Map<String, dynamic> data = jsonDecode(response.body);

    if (data.containsKey('error')) {
     
      throw Exception(data['error']['message']);
    }

    return WeatherModel.fromJson(data);
  } catch (e) {
    print("Error fetching weather: $e");
    return null;
  }
}

}
