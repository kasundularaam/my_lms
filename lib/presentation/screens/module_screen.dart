import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_lms/core/screen_arguments/content_screen_args.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/core/screen_arguments/content_list_screen_args.dart';
import 'package:my_lms/core/screen_arguments/module_screen_args.dart';
import 'package:my_lms/core/screen_arguments/quiz_screen_args.dart';
import 'package:my_lms/presentation/router/app_router.dart';
import 'package:my_lms/presentation/screens/widgets/content_card_small.dart';

class ModuleScreen extends StatefulWidget {
  final ModuleScreenArgs args;
  const ModuleScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _ModuleScreenState createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundWhite,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 5.h,
          ),
          Text(
            widget.args.moduleName,
            style: TextStyle(
                color: MyColors.accentColor,
                fontSize: 32.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: 90.w,
            padding: EdgeInsets.symmetric(vertical: 3.w),
            decoration: BoxDecoration(
              color: MyColors.offWhite,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [MyStyles.boxShadow],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    "Contents",
                    style: TextStyle(
                        color: MyColors.accentColor,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 16.h,
                  width: 90.w,
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return SizedBox(
                          width: 2.w,
                        );
                      } else if (index != 1 && index < 6) {
                        return ContentCardSmall(
                          args: ContentScreenArgs(
                            contentId: "$index",
                            contentName: "content $index",
                            subjectName: widget.args.subjectName,
                            subjectId: widget.args.subjectId,
                            moduleName: widget.args.moduleName,
                            moduleId: widget.args.moduleId,
                          ),
                        );
                      } else if (index == 6) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRouter.contentListScreen,
                            arguments: ContentListScreenArgs(
                              subjectId: widget.args.subjectId,
                              subjectName: widget.args.subjectName,
                              moduleId: widget.args.moduleId,
                              moduleName: widget.args.moduleName,
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              color: MyColors.offWhite,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "See All",
                                  style: TextStyle(
                                      color: MyColors.accentColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 20.sp,
                                  color: MyColors.accentColor,
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: 2.w,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRouter.contentListScreen,
                    arguments: ContentListScreenArgs(
                      subjectId: widget.args.subjectId,
                      subjectName: widget.args.subjectName,
                      moduleId: widget.args.moduleId,
                      moduleName: widget.args.moduleName,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      color: MyColors.accentColor,
                      borderRadius: BorderRadius.circular(5.w),
                      boxShadow: [MyStyles.boxShadow],
                    ),
                    child: Center(
                      child: Text(
                        "See All Contents",
                        style: TextStyle(
                            color: MyColors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    "Questions",
                    style: TextStyle(
                        color: MyColors.accentColor,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRouter.quizScreen,
                    arguments: QuizScreenArgs(
                      moduleId: widget.args.moduleId,
                      moduleName: widget.args.moduleName,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      color: MyColors.accentColor,
                      borderRadius: BorderRadius.circular(5.w),
                      boxShadow: [MyStyles.boxShadow],
                    ),
                    child: Center(
                      child: Text(
                        "Go To Quiz",
                        style: TextStyle(
                            color: MyColors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
