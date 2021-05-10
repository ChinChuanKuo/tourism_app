import 'package:flutter/material.dart';
import 'package:tourism_app/views/views.dart';

class Routers {
  HomeView homeRoute;
}

abstract class Routes {
  static const homeRoute = "/";
}

class RouterGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => HomeView(),
        );
    }
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('No route defined for ${settings.name}'),
        ),
      ),
    );
  }
}
