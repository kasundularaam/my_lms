import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/screen_arguments/add_eve_to_mod_scrn_args.dart';
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
      backgroundColor: MyColors.screenBgDarkColor,
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Container(
                height: (constraints.maxHeight * 10) / 100,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: EdgeInsets.all(5.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: MyColors.textColorLight,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        widget.args.moduleName,
                        style: TextStyle(
                            color: MyColors.textColorLight,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: (constraints.maxHeight * 90) / 100,
                decoration: BoxDecoration(
                  color: MyColors.screenBgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.w),
                    topRight: Radius.circular(8.w),
                  ),
                ),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            "Contents",
                            style: TextStyle(
                                color: MyColors.textColorLight,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          height: 16.h,
                          child:
                              BlocBuilder<ModuleScreenCubit, ModuleScreenState>(
                            builder: (context, state) {
                              if (state is ModuleScreenInitial) {
                                return Center(child: Text("Initial State"));
                              } else if (state is ModuleScreenLoading) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  color: MyColors.progressColor,
                                ));
                              } else if (state is ModuleScreenLoaded) {
                                return ListView(
                                  padding: EdgeInsets.all(0),
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    ListView.builder(
                                      padding: EdgeInsets.all(0),
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: state.contentList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Content content =
                                            state.contentList[index];
                                        return ContentCardSmall(
                                          args: ContentScreenArgs(
                                            contentId: content.id,
                                            contentName: content.contentTitle,
                                            subjectName:
                                                widget.args.subjectName,
                                            subjectId: widget.args.subjectId,
                                            moduleName: widget.args.moduleName,
                                            moduleId: widget.args.moduleId,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              } else if (state is ModuleScreenFailed) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: ErrorMsgBox(errorMsg: state.errorMsg),
                                );
                              } else if (state is ModuleScreenNoResult) {
                                return Center(
                                    child:
                                        ErrorMsgBox(errorMsg: state.message));
                              } else {
                                return Center(
                                  child: ErrorMsgBox(
                                      errorMsg: "unhandled state excecuted!"),
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
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            decoration: BoxDecoration(
                              color: MyColors.hpTopCardBgColor,
                              borderRadius: BorderRadius.circular(5.w),
                            ),
                            child: Center(
                              child: Text(
                                "See All Contents",
                                style: TextStyle(
                                    color: MyColors.textColorLight,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRouter.addEventToModScreen,
                            arguments: AddEveToModScrnArgs(
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
                              color: MyColors.progressColor,
                              borderRadius: BorderRadius.circular(5.w),
                            ),
                            child: Center(
                              child: Text(
                                "Add to schedual",
                                style: TextStyle(
                                  color: MyColors.textColorDark,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Divider(
                            color: MyColors.progressColor,
                            thickness: 0.2.w,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            "Questions",
                            style: TextStyle(
                                color: MyColors.textColorLight,
                                fontSize: 20.sp,
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
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            decoration: BoxDecoration(
                              color: MyColors.hpTopCardBgColor,
                              borderRadius: BorderRadius.circular(5.w),
                              boxShadow: [MyStyles.boxShadow],
                            ),
                            child: Center(
                              child: Text(
                                "Go To Quiz",
                                style: TextStyle(
                                    color: MyColors.textColorLight,
                                    fontSize: 14.sp,
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
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
