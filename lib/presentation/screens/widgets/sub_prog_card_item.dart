import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/my_colors.dart';

import 'package:my_lms/data/models/subject_model.dart';
import 'package:my_lms/logic/cubit/sub_prog_cubit/sub_prog_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/prograss_bar.dart';
import 'package:sizer/sizer.dart';

class SubProgCardItem extends StatelessWidget {
  final Subject subject;
  const SubProgCardItem({
    Key? key,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SubProgCubit>(context)
        .getSubProgress(subjectId: subject.id);
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          Text(
            subject.name,
            style: TextStyle(color: MyColors.textColorDark, fontSize: 16.sp),
          ),
          SizedBox(
            height: 2.h,
          ),
          BlocBuilder<SubProgCubit, SubProgState>(
            builder: (context, state) {
              if (state is SubProgInitial) {
                return MyPrograssBar(
                    width: 75.w,
                    max: 100,
                    progress: 0,
                    backgroundColor: MyColors.progressBgColor,
                    progressColor: MyColors.progressColor);
              } else if (state is SubProgLoading) {
                return MyPrograssBar(
                    width: 75.w,
                    max: 100,
                    progress: 0,
                    backgroundColor: MyColors.progressBgColor,
                    progressColor: MyColors.progressColor);
              } else if (state is SubProgLoaded) {
                return MyPrograssBar(
                    width: 75.w,
                    max: state.contentCount,
                    progress: state.fireContentCount,
                    backgroundColor: MyColors.progressBgColor,
                    progressColor: MyColors.progressColor);
              } else if (state is SubProgFailed) {
                return MyPrograssBar(
                    width: 75.w,
                    max: 100,
                    progress: 0,
                    backgroundColor: MyColors.progressBgColor,
                    progressColor: MyColors.progressColor);
              } else {
                return MyPrograssBar(
                    width: 75.w,
                    max: 100,
                    progress: 0,
                    backgroundColor: MyColors.progressBgColor,
                    progressColor: MyColors.progressColor);
              }
            },
          ),
          SizedBox(
            height: 1.h,
          ),
          Divider(
            color: MyColors.textColorDark,
            thickness: 0.2.w,
          ),
        ],
      ),
    );
  }
}
