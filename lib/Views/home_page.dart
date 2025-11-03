import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import 'package:weather_Application/providers/weather_provider.dart';
import 'package:weather_Application/route/app_router.dart';
import 'package:weather_Application/widget/no_weather_body.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // WeatherModel? weatherdata;

  @override
  Widget build(BuildContext context) {
    final weatherdata = Provider.of<WeatherProvider>(context).weatherdata;
    return Scaffold(
      appBar: AppBar(
  title: const Text('Weather App'),
  actions: [
    IconButton(
      onPressed: () {
        GoRouter.of(context).pushNamed(AppRouter.searchpage);
      },
      icon: const Icon(Icons.search),
    ),
  ],
),

    body: weatherdata == null
    ? NoWeatherBody()
    : Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              weatherdata.getThemeColor(),
              weatherdata.getThemeColor()[200]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Provider.of<WeatherProvider>(context).cityname ?? "",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      DateFormat('EEEE, d MMM yyyy – HH:mm')
                          .format(weatherdata!.date),
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 16),
                    Image.asset(
                      weatherdata.getImage(),
                      height: 100,
                    ),
                    Text(
                      "${weatherdata.temp.toInt()}°C",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      weatherdata.weatherStateName,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Max: ${weatherdata.maxtemp.toInt()}°"),
                        Text("Min: ${weatherdata.mintemp.toInt()}°"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
