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
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 5.h,
            ),
            HomeTopCard(),
            SubjectCard(),
            SubjectCard(),
            SubjectCard(),
            SubjectCard(),
            SubjectCard(),
            SubjectCard(),
            SubjectCard(),
            SubjectCard(),
          ],
        ),
      ),
    );
  }
}
