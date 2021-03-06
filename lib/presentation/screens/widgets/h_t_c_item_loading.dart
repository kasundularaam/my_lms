import 'package:flutter/material.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:sizer/sizer.dart';

class HTCItemLoadingW extends StatelessWidget {
  const HTCItemLoadingW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: MyColors.backgroundWhite,
            borderRadius: BorderRadius.circular(1.w),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          width: 50.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: MyColors.backgroundWhite,
            borderRadius: BorderRadius.circular(1.w),
          ),
        ),
      ],
    );
  }
}
