import 'package:flutter/material.dart';
import 'package:my_lms/core/screen_arguments/content_list_screen_args.dart';
import 'package:my_lms/core/screen_arguments/content_screen_args.dart';
import 'package:my_lms/core/screen_arguments/module_screen_args.dart';
import 'package:my_lms/core/screen_arguments/quiz_screen_args.dart';
import 'package:my_lms/core/screen_arguments/subject_screen_args.dart';

import 'package:my_lms/presentation/screens/auth_screen.dart';
import 'package:my_lms/presentation/screens/content_list_screen.dart';
import 'package:my_lms/presentation/screens/content_screen.dart';
import 'package:my_lms/presentation/screens/module_screen.dart';
import 'package:my_lms/presentation/screens/quiz_screen.dart';
import 'package:my_lms/presentation/screens/subject_screen.dart';

import '../../core/exceptions/route_exception.dart';
import '../screens/home_screen.dart';

class AppRouter {
  static const String home = '/home';
  static const String authScreen = '/';
  static const String subjectScreen = '/subjectScreen';
  static const String moduleScreen = '/moduleScreen';
  static const String contentListScreen = '/contentListScreen';
  static const String contentScreen = '/contentScreen';
  static const String quizScreen = '/quizScreen';

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
      case subjectScreen:
        final SubjectScreenArgs args = settings.arguments as SubjectScreenArgs;
        return MaterialPageRoute(
          builder: (_) => SubjectScreen(
            subjectId: args.subjectId,
            subjectName: args.subjectName,
          ),
        );
      case moduleScreen:
        final ModuleScreenArgs args = settings.arguments as ModuleScreenArgs;
        return MaterialPageRoute(
          builder: (_) => ModuleScreen(
            moduleId: args.moduleId,
            moduleName: args.moduleName,
          ),
        );

      case contentListScreen:
        final ContentListScreenArgs args =
            settings.arguments as ContentListScreenArgs;
        return MaterialPageRoute(
          builder: (_) => ContentListScreen(
            moduleId: args.moduleId,
            moduleName: args.moduleName,
          ),
        );

      case contentScreen:
        final ContentScreenArgs args = settings.arguments as ContentScreenArgs;
        return MaterialPageRoute(
          builder: (_) => ContentScreen(
            contentId: args.contentId,
            contentName: args.contentName,
          ),
        );

      case quizScreen:
        final QuizScreenArgs args = settings.arguments as QuizScreenArgs;
        return MaterialPageRoute(
          builder: (_) => QuizScreen(
            moduleId: args.moduleId,
            moduleName: args.moduleName,
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
