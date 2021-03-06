import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/my_enums.dart';
import 'package:my_lms/logic/cubit/exam_countdown_cubit/exam_countdown_cubit.dart';
import 'package:my_lms/logic/cubit/home_nav_cubit/home_nav_cubit.dart';
import 'package:my_lms/logic/cubit/home_tab_cubit/home_tab_cubit.dart';
import 'package:my_lms/logic/cubit/show_cal_events_cubit/show_cal_events_cubit.dart';
import 'package:my_lms/presentation/screens/home_tabs/countdown_tab.dart';
import 'package:my_lms/presentation/screens/home_tabs/events_tab.dart';
import 'package:my_lms/presentation/screens/home_tabs/home_tab.dart';
import 'package:my_lms/presentation/screens/home_tabs/profile_tab.dart';
import 'package:my_lms/presentation/screens/widgets/bottom_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeTabCubit _homeTabCubit = HomeTabCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeNavCubit(),
      child: Scaffold(
        backgroundColor: MyColors.screenBgDarkColor,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: (constraints.maxHeight * 90) / 100,
                    child: BlocBuilder<HomeNavCubit, HomeNavState>(
                        builder: (context, state) {
                      if (state is HomeNavInitial) {
                        return BlocProvider.value(
                          value: _homeTabCubit,
                          child: HomeTab(),
                        );
                      } else if (state is HomeScreenNavigate) {
                        if (state.homeNav == HomeNav.toHome) {
                          return BlocProvider.value(
                            value: _homeTabCubit,
                            child: HomeTab(),
                          );
                        } else if (state.homeNav == HomeNav.toProfile) {
                          return ProfileTab();
                        } else if (state.homeNav == HomeNav.toEvents) {
                          return BlocProvider(
                            create: (context) => ShowCalEventsCubit(),
                            child: EventsTab(),
                          );
                        } else if (state.homeNav == HomeNav.toCountDown) {
                          return BlocProvider(
                            create: (context) => ExamCountdownCubit(),
                            child: CountDownTab(),
                          );
                        } else {
                          return BlocProvider.value(
                            value: _homeTabCubit,
                            child: HomeTab(),
                          );
                        }
                      } else {
                        return BlocProvider.value(
                          value: _homeTabCubit,
                          child: HomeTab(),
                        );
                      }
                    }),
                  ),
                  BottomTab(
                    height: (constraints.maxHeight * 9) / 100,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
