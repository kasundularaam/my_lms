import 'package:flutter/material.dart';
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
    return Column(
      children: [
        Container(
          height: 30.h,
          width: 90.w,
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
                  Text(
                    "Kasun",
                    style: TextStyle(
                      color: MyColors.white,
                      fontSize: 22.sp,
                    ),
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
