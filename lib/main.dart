import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weather_Application/providers/weather_provider.dart';
import 'package:weather_Application/route/router_generator.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Provider.of<WeatherProvider>(context).weatherdata == null
            ? Colors.blue
            : Provider.of<WeatherProvider>(
                context,
              ).weatherdata!.getThemeColor(),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: RouterGenerator.router,
    );
  }
}
