import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/screen_arguments/content_screen_args.dart';
import 'package:my_lms/data/models/content_model.dart';
import 'package:my_lms/logic/cubit/module_screen_cubit/module_screen_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
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
  void initState() {
    super.initState();
    BlocProvider.of<ModuleScreenCubit>(context)
        .loadContentList(moduleId: widget.args.moduleId);
  }

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
                  child: BlocBuilder<ModuleScreenCubit, ModuleScreenState>(
                    builder: (context, state) {
                      if (state is ModuleScreenInitial) {
                        return Center(child: Text("Initial State"));
                      } else if (state is ModuleScreenLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ModuleScreenLoaded) {
                        return ListView.builder(
                          padding: EdgeInsets.all(0),
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.contentList.length,
                          itemBuilder: (BuildContext context, int index) {
                            Content content = state.contentList[index];
                            return ContentCardSmall(
                              args: ContentScreenArgs(
                                contentId: content.id,
                                contentName: content.contentTitle,
                                subjectName: widget.args.subjectName,
                                subjectId: widget.args.subjectId,
                                moduleName: widget.args.moduleName,
                                moduleId: widget.args.moduleId,
                              ),
                            );
                          },
                        );
                      } else if (state is ModuleScreenFailed) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: ErrorMsgBox(errorMsg: state.errorMsg),
                        );
                      } else {
                        return Text("unhandled state excecuted!");
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
