import 'package:flutter/material.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:sizer/sizer.dart';

class HomeTopCard extends StatelessWidget {
  const HomeTopCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30.h,
          width: 90.w,
          decoration: BoxDecoration(
              color: MyColors.accentColor,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [MyStyles.boxShadow]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  "Subjects",
                  style: TextStyle(color: MyColors.white, fontSize: 32.sp),
                ),
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
