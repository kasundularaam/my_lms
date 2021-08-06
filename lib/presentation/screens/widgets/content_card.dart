import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/screen_arguments/content_screen_args.dart';
import 'package:my_lms/presentation/router/app_router.dart';

class ContentCard extends StatelessWidget {
  final ContentScreenArgs args;
  const ContentCard({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouter.contentScreen,
              arguments: args,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.w),
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(5.w),
            ),
            child: Center(
              child: Text(
                args.contentName,
                style: TextStyle(
                  color: MyColors.accentColor,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.w,
        ),
      ],
    );
  }
}
