import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    AuthCubit _authCubit = AuthCubit(firebaseAuth: _firebaseAuth);
    print("========================================================");
    print("NEW INSTANCE CREATED FOR FIREBASEAUTH AND AUTH CUBIT");
    print("========================================================");
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
