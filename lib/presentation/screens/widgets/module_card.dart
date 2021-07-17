import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/core/screen_arguments/module_screen_args.dart';
import 'package:my_lms/presentation/router/app_router.dart';

class ModuleCard extends StatelessWidget {
  final String moduleId;
  final String moduleName;
  final int contentCount;
  final int quizCount;
  const ModuleCard({
    Key? key,
    required this.moduleId,
    required this.moduleName,
    required this.contentCount,
    required this.quizCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouter.moduleScreen,
              arguments: ModuleScreenArgs(
                moduleId: moduleId,
                moduleName: moduleName,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  moduleName,
                  style: TextStyle(
                      color: MyColors.accentColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Contents: $contentCount",
                      style: TextStyle(
                          color: MyColors.shadedBlack,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Quiz: $quizCount",
                      style: TextStyle(
                          color: MyColors.shadedBlack,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
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
