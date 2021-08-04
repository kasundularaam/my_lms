import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/logic/cubit/profile_top_card_cubit/profile_top_card_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';

class ProfileTopCard extends StatelessWidget {
  final Widget child;
  const ProfileTopCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileTopCardCubit>(context).getUserDetails();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
              color: MyColors.accentColor,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [MyStyles.boxShadow]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              height: 3.h,
                              decoration: BoxDecoration(
                                color: MyColors.backgroundWhite,
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
                                color: MyColors.backgroundWhite,
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
                                color: MyColors.white,
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                              state.fireUser.email,
                              style: TextStyle(
                                color: MyColors.white,
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
                                color: MyColors.backgroundWhite,
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
                                color: MyColors.backgroundWhite,
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
                child: child,
              )
            ],
          ),
        ),
        SizedBox(
          height: 5.w,
        )
      ],
    );
  }
}
