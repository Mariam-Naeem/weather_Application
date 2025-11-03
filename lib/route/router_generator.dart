import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_Application/Views/home_page.dart';
import 'package:weather_Application/Views/search_page.dart';
import 'package:weather_Application/route/app_router.dart';

class RouterGenerator {
  static GoRouter router = GoRouter(
    initialLocation: AppRouter.homepage,
    routes: [
      GoRoute(
        path: AppRouter.searchpage,
        name: AppRouter.searchpage,
        builder: (context, state) => SearchPage(),
      ),
      GoRoute(
        path: AppRouter.homepage,
        name: AppRouter.homepage,
        builder: (context, state) => HomeView(),
      ),
    ],
  );
}

