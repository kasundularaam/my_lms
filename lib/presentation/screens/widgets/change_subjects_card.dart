import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/data/models/subject_model.dart';

class ChangeSubjectsCard extends StatefulWidget {
  final List<Subject> subjects;
  const ChangeSubjectsCard({
    Key? key,
    required this.subjects,
  }) : super(key: key);

  @override
  _ChangeSubjectsCardState createState() => _ChangeSubjectsCardState();
}

class _ChangeSubjectsCardState extends State<ChangeSubjectsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
          color: MyColors.textColorLight,
          borderRadius: BorderRadius.circular(2.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Subjects",
            style: TextStyle(
              color: MyColors.textColorDark,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Column(
            children: buildSubjectList(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  "CHANGE",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: MyColors.green,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildSubjectList() {
    List<Widget> subList = [];
    widget.subjects.forEach((sub) {
      subList.add(buildSubject(subjectName: sub.name));
    });
    return subList;
  }

  Widget buildSubject({required String subjectName}) {
    return Column(
      children: [
        Container(
          width: 100.w,
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: MyColors.lightGray.withOpacity(0.2),
            borderRadius: BorderRadius.circular(1.w),
          ),
          child: Text(
            subjectName,
            style: TextStyle(
              fontSize: 14.sp,
              color: MyColors.textColorDark,
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}
