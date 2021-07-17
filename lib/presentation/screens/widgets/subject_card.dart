import 'package:flutter/material.dart';
import 'package:my_lms/core/screen_arguments/subject_screen_args.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/presentation/router/app_router.dart';
import 'package:my_lms/presentation/screens/widgets/prograss_bar.dart';

class SubjectCard extends StatelessWidget {
  final String id;
  final String name;
  final int modules;
  final int contents;
  final int quiz;
  final int completdModules;
  final int completedContents;
  final int completedQuiz;
  const SubjectCard({
    Key? key,
    required this.id,
    required this.name,
    required this.modules,
    required this.contents,
    required this.quiz,
    required this.completdModules,
    required this.completedContents,
    required this.completedQuiz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            AppRouter.subjectScreen,
            arguments: SubjectScreenArgs(
              subjectId: id,
              subjectName: name,
            ),
          ),
          child: Container(
            width: 90.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.circular(5.w),
                boxShadow: [MyStyles.boxShadow]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      color: MyColors.accentColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Modules",
                      style: TextStyle(
                          color: MyColors.accentColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Column(
                      children: [
                        Text("$completdModules/$modules",
                            style: TextStyle(
                                color: MyColors.accentColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400)),
                        MyPrograssBar(
                          width: 12.w,
                          max: modules,
                          progress: completdModules,
                          backgroundColor: MyColors.offWhite,
                          progressColor: MyColors.accentColor,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 2.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Contents",
                        style: TextStyle(
                            color: MyColors.accentColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600)),
                    Column(
                      children: [
                        Text("$completedContents/$contents",
                            style: TextStyle(
                                color: MyColors.accentColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400)),
                        MyPrograssBar(
                          width: 12.w,
                          max: contents,
                          progress: completedContents,
                          backgroundColor: MyColors.offWhite,
                          progressColor: MyColors.accentColor,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 2.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Quiz",
                        style: TextStyle(
                            color: MyColors.accentColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600)),
                    Column(
                      children: [
                        Text("$completedQuiz/$quiz",
                            style: TextStyle(
                                color: MyColors.accentColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400)),
                        MyPrograssBar(
                          width: 12.w,
                          max: quiz,
                          progress: completedQuiz,
                          backgroundColor: MyColors.offWhite,
                          progressColor: MyColors.accentColor,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.w,
        )
      ],
    );
  }
}
