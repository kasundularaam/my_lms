import 'package:flutter/material.dart';
import 'package:my_lms/presentation/screens/widgets/module_card.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/presentation/screens/widgets/my_text_field.dart';

class SubjectScreen extends StatefulWidget {
  final String subjectId;
  final String subjectName;
  const SubjectScreen({
    Key? key,
    required this.subjectId,
    required this.subjectName,
  }) : super(key: key);

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
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
          Container(
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: MyColors.accentColor,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [MyStyles.boxShadow],
            ),
            child: Column(
              children: [
                Text(
                  widget.subjectName,
                  style: TextStyle(
                      color: MyColors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.w,
                ),
                MyTextField(
                    onChanged: (text) {},
                    onSubmitted: (text) {},
                    textInputAction: TextInputAction.search,
                    isPassword: false,
                    hintText: "Search..."),
              ],
            ),
          ),
          SizedBox(
            height: 5.w,
          ),
          ListView.builder(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return ModuleCard(
                  moduleId: "1",
                  moduleName: "Electronics",
                  contentCount: 245,
                  quizCount: 371);
            },
          ),
        ],
      ),
    );
  }
}
