import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/logic/cubit/logout_cubit/logout_cubit.dart';
import 'package:my_lms/logic/cubit/profile_top_card_cubit/profile_top_card_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';

class ProfileTopCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileTopCardCubit>(context).getUserDetails();
    return Column(
      children: [
        Container(
          width: 95.w,
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            color: MyColors.hpTopCardBgColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.w),
              bottomLeft: Radius.circular(5.w),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.w),
                    child: Image.asset(
                      "assets/images/boy.jpg",
                      width: 24.w,
                      height: 24.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  BlocBuilder<ProfileTopCardCubit, ProfileTopCardState>(
                    builder: (context, state) {
                      if (state is ProfileTopCardInitial) {
                        return Center(child: Text("Initial State"));
                      } else if (state is ProfileTopCardLoading) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 20.w,
                              height: 1.6.h,
                              decoration: BoxDecoration(
                                color: MyColors.textColorLight,
                                borderRadius: BorderRadius.circular(1.w),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              width: 40.w,
                              height: 1.2.h,
                              decoration: BoxDecoration(
                                color: MyColors.textColorLight,
                                borderRadius: BorderRadius.circular(1.w),
                              ),
                            ),
                          ],
                        );
                      } else if (state is ProfileTopCardLoaded) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.fireUser.name,
                              style: TextStyle(
                                color: MyColors.textColorLight,
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                              state.fireUser.email,
                              style: TextStyle(
                                color: MyColors.textColorLight,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        );
                      } else if (state is ProfileTopCardFailed) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 20.w,
                              height: 3.h,
                              decoration: BoxDecoration(
                                color: MyColors.textColorLight,
                                borderRadius: BorderRadius.circular(1.w),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              width: 40.w,
                              height: 3.w,
                              decoration: BoxDecoration(
                                color: MyColors.textColorLight,
                                borderRadius: BorderRadius.circular(1.w),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: ErrorMsgBox(
                              errorMsg: "unhandled state excecuted!"),
                        );
                      }
                    },
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () => BlocProvider.of<LogoutCubit>(context).logOut(),
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(2.w),
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
              )
            ],
          ),
        ),
        SizedBox(
          height: 3.h,
        )
      ],
    );
  }
}
