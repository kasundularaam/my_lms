import 'package:flutter/material.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/presentation/screens/widgets/prograss_bar.dart';
import 'package:sizer/sizer.dart';

class HomeTopCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5.w),
          width: 90.w,
          decoration: BoxDecoration(
              color: MyColors.accentColor,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [MyStyles.boxShadow]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Subjects",
                style: TextStyle(color: MyColors.white, fontSize: 32.sp),
              ),
              SizedBox(
                height: 5.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Combind Maths",
                    style: TextStyle(color: MyColors.white, fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  MyPrograssBar(
                      width: 20.w,
                      max: 100,
                      progress: 30,
                      backgroundColor: MyColors.backgroundWhite,
                      progressColor: MyColors.primaryColor),
                  SizedBox(
                    height: 3.w,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Physics",
                    style: TextStyle(color: MyColors.white, fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  MyPrograssBar(
                      width: 20.w,
                      max: 100,
                      progress: 78,
                      backgroundColor: MyColors.backgroundWhite,
                      progressColor: MyColors.primaryColor),
                  SizedBox(
                    height: 3.w,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Information and Comunication Technology",
                    style: TextStyle(color: MyColors.white, fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  MyPrograssBar(
                      width: 20.w,
                      max: 100,
                      progress: 54,
                      backgroundColor: MyColors.backgroundWhite,
                      progressColor: MyColors.primaryColor),
                  SizedBox(
                    height: 3.w,
                  ),
                ],
              ),
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
