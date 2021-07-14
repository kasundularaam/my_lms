import 'package:flutter/material.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:sizer/sizer.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20.h,
          width: 90.w,
          decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [MyStyles.boxShadow]),
        ),
        SizedBox(
          height: 5.w,
        )
      ],
    );
  }
}
