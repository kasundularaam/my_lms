import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/logic/cubit/logout_cubit/logout_cubit.dart';
import 'package:my_lms/logic/cubit/profile_top_card_cubit/profile_top_card_cubit.dart';
import 'package:my_lms/logic/cubit/sub_prog_card_cubit/sub_prog_card_cubit.dart';
import 'package:my_lms/logic/cubit/today_worls_cubit/today_works_cubit.dart';
import 'package:my_lms/logic/cubit/work_card_list_cubit/work_card_list_cubit.dart';
import 'package:my_lms/presentation/router/app_router.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:my_lms/presentation/screens/widgets/profile_top_card.dart';
import 'package:my_lms/presentation/screens/widgets/sub_prog_card.dart';
import 'package:my_lms/presentation/screens/widgets/today_worked_details.dart';
import 'package:my_lms/presentation/screens/widgets/work_card_list.dart';
import 'package:sizer/sizer.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10.w),
        bottomRight: Radius.circular(10.w),
      ),
      child: Container(
        color: MyColors.screenBgColor,
        child: ListView(physics: BouncingScrollPhysics(), children: [
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
          ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            children: [
              Container(
                child: BlocProvider(
                  create: (context) => TodayWorksCubit(),
                  child: TodayWorkedDetails(),
                ),
              ),
              BlocProvider(
                create: (context) => SubProgCardCubit(),
                child: SubProgCard(),
              ),
              Divider(
                thickness: 0.2.w,
                color: MyColors.textColorLight,
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Your activities",
                style: TextStyle(
                    color: MyColors.textColorLight,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 3.h,
              ),
              BlocProvider(
                create: (context) => WorkCardListCubit(),
                child: WorkCardList(),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
