import 'package:flutter/material.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/presentation/screens/widgets/home_top_card.dart';
import 'package:my_lms/presentation/screens/widgets/subject_card.dart';
import 'package:sizer/sizer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.offWhite,
        boxShadow: [MyStyles.boxShadow],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.w),
          bottomRight: Radius.circular(10.w),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.w),
          bottomRight: Radius.circular(10.w),
        ),
        child: ListView(
          padding: const EdgeInsets.all(0),
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 5.h,
            ),
            HomeTopCard(),
            SubjectCard(
                id: "1",
                name: "Physics",
                modules: 103,
                contents: 3021,
                quiz: 4590,
                completdModules: 30,
                completedContents: 112,
                completedQuiz: 430),
            SubjectCard(
                id: "1",
                name: "Combind Maths",
                modules: 103,
                contents: 3021,
                quiz: 4590,
                completdModules: 30,
                completedContents: 112,
                completedQuiz: 430),
            SubjectCard(
                id: "1",
                name: "Information Communication and Technology",
                modules: 103,
                contents: 3021,
                quiz: 4590,
                completdModules: 30,
                completedContents: 112,
                completedQuiz: 430),
          ],
        ),
      ),
    );
  }
}
