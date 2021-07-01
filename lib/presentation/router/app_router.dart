import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/logic/cubit/auth_cubit.dart';
import 'package:my_lms/presentation/screens/auth_screen.dart';

import '../../core/constants/strings.dart';
import '../../core/exceptions/route_exception.dart';
import '../screens/pages/home_page.dart';

class AppRouter {
  static const String home = '/home';
  static const String authScreen = '/';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    AuthCubit _authCubit = AuthCubit();
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            title: Strings.homeScreenTitle,
          ),
        );
      case authScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _authCubit,
            child: AuthScreen(),
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
