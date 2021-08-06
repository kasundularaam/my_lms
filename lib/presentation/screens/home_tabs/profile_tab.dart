import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/logic/cubit/logout_cubit/logout_cubit.dart';
import 'package:my_lms/logic/cubit/profile_top_card_cubit/profile_top_card_cubit.dart';
import 'package:my_lms/logic/cubit/sub_prog_card_cubit/sub_prog_card_cubit.dart';
import 'package:my_lms/logic/cubit/today_worls_cubit/today_works_cubit.dart';
import 'package:my_lms/presentation/router/app_router.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:my_lms/presentation/screens/widgets/profile_top_card.dart';
import 'package:my_lms/presentation/screens/widgets/sub_prog_card.dart';
import 'package:my_lms/presentation/screens/widgets/today_worked_details.dart';
import 'package:sizer/sizer.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutCubit(),
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.screenBgColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.w),
            bottomRight: Radius.circular(10.w),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.w),
            bottomRight: Radius.circular(10.w),
          ),
          child: BlocConsumer<LogoutCubit, LogoutState>(
            listener: (context, state) {
              if (state is LogoutSucceed) {
                Navigator.popAndPushNamed(context, AppRouter.authScreen);
              }
            },
            builder: (context, state) {
              if (state is LogoutInitial) {
                return ListView(physics: BouncingScrollPhysics(), children: [
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      SizedBox(width: 5.w),
                      Text(
                        "Profile",
                        style: TextStyle(
                            color: MyColors.textColorLight,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      BlocProvider(
                        create: (context) => ProfileTopCardCubit(),
                        child: ProfileTopCard(),
                      ),
                    ],
                  ),
                  Container(
                    child: BlocProvider(
                      create: (context) => TodayWorksCubit(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: TodayWorkedDetails(),
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => SubProgCardCubit(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: SubProgCard(),
                    ),
                  ),
                ]);
              } else if (state is LogoutLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LogoutFailed) {
                return Center(
                  child: ErrorMsgBox(
                    errorMsg: state.errorMsg,
                  ),
                );
              } else {
                return Text("unhandled state excecuted!");
              }
            },
          ),
        ),
      ),
    );
  }
}
