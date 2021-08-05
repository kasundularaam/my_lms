import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/logic/cubit/h_t_c_Item_cubit/h_t_c_item_cubit.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/data/models/subject_model.dart';
import 'package:my_lms/presentation/screens/widgets/home_top_card_item.dart';

class HomeTopCard extends StatelessWidget {
  final List<Subject> subjectList;
  const HomeTopCard({
    Key? key,
    required this.subjectList,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5.w),
          width: 95.w,
          decoration: BoxDecoration(
            color: MyColors.accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.w),
              bottomLeft: Radius.circular(5.w),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Subjects",
                style: TextStyle(color: MyColors.white, fontSize: 20.sp),
              ),
              SizedBox(
                height: 5.w,
              ),
              Column(
                children: builedItemList(subjectList: subjectList),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.w,
        )
      ],
    );
  }

  List<Widget> builedItemList({required List<Subject> subjectList}) {
    List<Widget> itemList = [];
    subjectList.forEach((subject) {
      itemList.add(
        BlocProvider(
          create: (context) => HTCItemCubit(),
          child: HomeTopCardItem(
            subject: subject,
          ),
        ),
      );
    });
    return itemList;
  }
}
