import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/core/screen_arguments/content_screen_args.dart';
import 'package:my_lms/presentation/router/app_router.dart';

class ContentCard extends StatelessWidget {
  final String contentId;
  final String contentName;
  const ContentCard({
    Key? key,
    required this.contentId,
    required this.contentName,
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
              arguments: ContentScreenArgs(
                contentId: contentId,
                contentName: contentName,
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [MyStyles.boxShadow],
            ),
            child: Text(
              contentName,
              style: TextStyle(
                  color: MyColors.accentColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600),
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
