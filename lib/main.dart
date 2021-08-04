import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/notifications/notification_service.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';
import 'package:sizer/sizer.dart';

import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'logic/debug/app_bloc_observer.dart';
import 'presentation/router/app_router.dart';

NotificationService notificationService = NotificationService();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  notificationService.initNotificationsSettings();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseRepo.getBarChartDataList();
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: Strings.appTitle,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
      );
    });
  }
}
