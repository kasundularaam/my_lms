import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/logic/cubit/logout_cubit/logout_cubit.dart';
import 'package:my_lms/presentation/router/app_router.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:my_lms/presentation/screens/widgets/profile_top_card.dart';
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
          color: MyColors.offWhite,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.w),
            bottomRight: Radius.circular(10.w),
          ),
          boxShadow: [MyStyles.boxShadow],
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
                  SizedBox(height: 5.h),
                  ProfileTopCard(
                    child: InkWell(
                      onTap: () =>
                          BlocProvider.of<LogoutCubit>(context).logOut(),
                      child: Container(
                        child: Text(
                          "Log Out",
                          style: TextStyle(
                            color: MyColors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
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
