import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/data/models/subject_model.dart';
import 'package:my_lms/logic/cubit/sub_prog_card_cubit/sub_prog_card_cubit.dart';
import 'package:my_lms/logic/cubit/sub_prog_cubit/sub_prog_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/sub_prog_card_item.dart';
import 'package:sizer/sizer.dart';

class SubProgCard extends StatelessWidget {
  const SubProgCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SubProgCardCubit>(context).getSubjects();
    return Column(
      children: [
        Container(
          width: 100.w,
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
              color: MyColors.textColorLight,
              borderRadius: BorderRadius.circular(5.w)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All Time Progress",
                style:
                    TextStyle(color: MyColors.textColorDark, fontSize: 18.sp),
              ),
              SizedBox(
                height: 3.h,
              ),
              BlocBuilder<SubProgCardCubit, SubProgCardState>(
                builder: (context, state) {
                  if (state is SubProgCardInitial) {
                    return Text("Initial State");
                  } else if (state is SubProgCardLoading) {
                    return Text("Loading...");
                  } else if (state is SubProgCardLoaded) {
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        children:
                            builedItemList(subjectList: state.subjectList),
                      ),
                    );
                  } else if (state is SubProgCardFailed) {
                    return Text("something went wrong!");
                  } else {
                    return Text("unhandled state excecuted!");
                  }
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 3.h,
        )
      ],
    );
  }

  List<Widget> builedItemList({required List<Subject> subjectList}) {
    List<Widget> itemList = [];
    subjectList.forEach((subject) {
      itemList.add(
        BlocProvider(
          create: (context) => SubProgCubit(),
          child: SubProgCardItem(
            subject: subject,
          ),
        ),
      );
    });
    return itemList;
  }
}
