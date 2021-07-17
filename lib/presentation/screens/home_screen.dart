import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/my_enums.dart';
import 'package:my_lms/logic/cubit/home_nav_cubit/home_nav_cubit.dart';
import 'package:sizer/sizer.dart';
import 'package:my_lms/presentation/screens/home_tabs/home_tab.dart';
import 'package:my_lms/presentation/screens/home_tabs/profile_tab.dart';
import 'package:my_lms/presentation/screens/widgets/bottom_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeNavCubit(),
      child: Scaffold(
        backgroundColor: MyColors.backgroundWhite,
        body: Container(
          child: Column(
            children: [
              Container(
                height: 91.h,
                width: 100.w,
                child: BlocBuilder<HomeNavCubit, HomeNavState>(
                    builder: (context, state) {
                  if (state is HomeNavInitial) {
                    return HomeTab();
                  } else if (state is HomeScreenNavigate) {
                    if (state.homeNav == HomeNav.toHome) {
                      return HomeTab();
                    } else if (state.homeNav == HomeNav.toProfile) {
                      return ProfileTab();
                    } else {
                      return HomeTab();
                    }
                  } else {
                    return HomeTab();
                  }
                }),
              ),
              SizedBox(
                height: 1.h,
              ),
              BottomTab()
            ],
          ),
        ),
      ),
    );
  }
}
