import 'package:flutter/material.dart';

import 'package:my_lms/presentation/screens/auth_screen.dart';

import '../../core/exceptions/route_exception.dart';
import '../screens/home_screen.dart';

class AppRouter {
  static const String home = '/home';
  static const String authScreen = '/';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case authScreen:
        return MaterialPageRoute(
          builder: (_) => AuthScreen(),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
