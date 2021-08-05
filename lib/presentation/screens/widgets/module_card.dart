import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/logic/cubit/module_card_cubit/module_card_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:my_lms/presentation/screens/widgets/loading_container.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/core/screen_arguments/module_screen_args.dart';
import 'package:my_lms/presentation/router/app_router.dart';

class ModuleCard extends StatelessWidget {
  final ModuleScreenArgs args;
  const ModuleCard({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ModuleCardCubit>(context)
        .loadModuleCardDetails(moduleId: args.moduleId);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouter.moduleScreen,
              arguments: ModuleScreenArgs(
                subjectId: args.subjectId,
                subjectName: args.subjectName,
                moduleId: args.moduleId,
                moduleName: args.moduleName,
              ),
            );
          },
          child: Container(
            width: 100.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(5.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  args.moduleName,
                  style: TextStyle(
                      color: MyColors.accentColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.w,
                ),
                BlocBuilder<ModuleCardCubit, ModuleCardState>(
                  builder: (context, state) {
                    if (state is ModuleCardInitial) {
                      return Text("Initial State");
                    } else if (state is ModuleCardLoading) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LoadingContainer(width: 30.w, height: 2.h),
                          LoadingContainer(width: 15.w, height: 2.h),
                        ],
                      );
                    } else if (state is ModuleCardLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Contents: ${state.contentCount}",
                            style: TextStyle(
                                color: MyColors.shadedBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Quiz: ${state.quizCount}",
                            style: TextStyle(
                                color: MyColors.shadedBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      );
                    } else if (state is ModuleCardFailed) {
                      return ErrorMsgBox(errorMsg: state.errorMsg);
                    } else {
                      return Center(child: Text("unhandled state excecuted!"));
                    }
                  },
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
