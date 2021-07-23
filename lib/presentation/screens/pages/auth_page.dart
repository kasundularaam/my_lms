import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/shared_prefs_keys.dart';
import 'package:my_lms/core/my_enums.dart';
import 'package:my_lms/core/screen_arguments/content_screen_args.dart';
import 'package:my_lms/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:my_lms/logic/cubit/auth_nav_cubit/authscreen_nav_cubit.dart';
import 'package:my_lms/presentation/router/app_router.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).checkUserStatus();
  }

  Future<void> goToHome() async {
    await Future.delayed(Duration(milliseconds: 300));
    Navigator.popAndPushNamed(context, AppRouter.home);
  }

  Future<void> navigateToLogin() async {
    await Future.delayed(Duration(milliseconds: 300));
    BlocProvider.of<AuthscreenNavCubit>(context)
        .authNavigate(authNav: AuthNav.toLogin);
  }

  Future<void> checkSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isOnWorking = prefs.getBool(SharedPrefsKeys.isOnWorkingKey);
    if (isOnWorking != null) {
      if (isOnWorking) {
        Navigator.popAndPushNamed(
          context,
          AppRouter.workingScreen,
          arguments: ContentScreenArgs(
            contentId: prefs.getString(SharedPrefsKeys.contentIdKey) ?? "",
            contentName: prefs.getString(SharedPrefsKeys.contentNameKey) ?? "",
            subjectName: prefs.getString(SharedPrefsKeys.subjectNameKey) ?? "",
            subjectId: prefs.getString(SharedPrefsKeys.subjectIdKey) ?? "",
            moduleName: prefs.getString(SharedPrefsKeys.moduleNameKey) ?? "",
            moduleId: prefs.getString(SharedPrefsKeys.moduleIdKey) ?? "",
          ),
        );
      } else {
        goToHome();
      }
    } else {
      goToHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthFailed) {
          return buildFailedState(state.errorMsg);
        } else if (state is AuthCheckUserStatus) {
          if (state.userStatus) {
            checkSP();
          } else {
            navigateToLogin();
          }
          return Container(
            child: Center(
              child: Text(state.statusMsg),
            ),
          );
        } else {
          return Text("unhandled state excecuted!");
        }
      },
    );
  }

  Widget buildFailedState(String errorMsg) {
    return Column(children: [
      ErrorMsgBox(errorMsg: errorMsg),
      SizedBox(
        height: 15.w,
      ),
      TextButton(
        onPressed: () => BlocProvider.of<AuthCubit>(context).checkUserStatus(),
        child: Text("Try Again"),
      ),
    ]);
  }
}
