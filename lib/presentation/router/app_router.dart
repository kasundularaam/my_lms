import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/screen_arguments/add_event_screen_args.dart';
import 'package:my_lms/core/screen_arguments/content_list_screen_args.dart';
import 'package:my_lms/core/screen_arguments/content_screen_args.dart';
import 'package:my_lms/core/screen_arguments/module_screen_args.dart';
import 'package:my_lms/core/screen_arguments/quiz_screen_args.dart';
import 'package:my_lms/core/screen_arguments/subject_screen_args.dart';
import 'package:my_lms/logic/cubit/add_con_eve_cal_cubit/add_con_eve_cal_cubit.dart';
import 'package:my_lms/logic/cubit/auth_nav_cubit/authscreen_nav_cubit.dart';
import 'package:my_lms/logic/cubit/content_list_screen_cubit/content_list_screen_cubit.dart';
import 'package:my_lms/logic/cubit/module_screen_cubit/module_screen_cubit.dart';
import 'package:my_lms/logic/cubit/quiz_screen_cubit/quiz_screen_cubit.dart';
import 'package:my_lms/logic/cubit/subject_screen_cubit/subject_screen_cubit.dart';
import 'package:my_lms/logic/cubit/working_cubit/working_cubit.dart';
import 'package:my_lms/presentation/screens/add_event_main_screen.dart';
import 'package:my_lms/presentation/screens/add_event_screen.dart';

import 'package:my_lms/presentation/screens/auth_screen.dart';
import 'package:my_lms/presentation/screens/content_list_screen.dart';
import 'package:my_lms/presentation/screens/content_screen.dart';
import 'package:my_lms/presentation/screens/module_screen.dart';
import 'package:my_lms/presentation/screens/quiz_screen.dart';
import 'package:my_lms/presentation/screens/subject_screen.dart';
import 'package:my_lms/presentation/screens/working_screen.dart';

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
  static const String workingScreen = '/workingScreen';
  static const String addEventScreen = '/addEventScreen';
  static const String addEventMainScreen = '/addEventMainScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    WorkingCubit _workingCubit = WorkingCubit();
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case authScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthscreenNavCubit(),
            child: AuthScreen(),
          ),
        );
      case subjectScreen:
        final SubjectScreenArgs args = settings.arguments as SubjectScreenArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SubjectScreenCubit(),
            child: SubjectScreen(
              args: args,
            ),
          ),
        );
      case moduleScreen:
        final ModuleScreenArgs args = settings.arguments as ModuleScreenArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ModuleScreenCubit(),
            child: ModuleScreen(
              args: args,
            ),
          ),
        );

      case contentListScreen:
        final ContentListScreenArgs args =
            settings.arguments as ContentListScreenArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ContentListScreenCubit(),
            child: ContentListScreen(
              args: args,
            ),
          ),
        );

      case contentScreen:
        final ContentScreenArgs args = settings.arguments as ContentScreenArgs;
        return MaterialPageRoute(
          builder: (_) => ContentScreen(
            args: args,
          ),
        );

      case quizScreen:
        final QuizScreenArgs args = settings.arguments as QuizScreenArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => QuizScreenCubit(),
            child: QuizScreen(
              moduleId: args.moduleId,
              moduleName: args.moduleName,
            ),
          ),
        );
      case workingScreen:
        final ContentScreenArgs args = settings.arguments as ContentScreenArgs;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _workingCubit,
                  child: WorkingScreen(
                    args: args,
                  ),
                ));
      case addEventScreen:
        final AddEventScreenArgs args =
            settings.arguments as AddEventScreenArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddConEventToCalCubit(),
            child: AddEventScreen(
              args: args,
            ),
          ),
        );
      case addEventMainScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddConEventToCalCubit(),
            child: AddEventMainScreen(),
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
