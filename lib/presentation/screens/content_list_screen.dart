import 'package:flutter/material.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/presentation/screens/widgets/content_card.dart';
import 'package:my_lms/presentation/screens/widgets/module_card.dart';
import 'package:my_lms/presentation/screens/widgets/my_text_field.dart';
import 'package:sizer/sizer.dart';

class ContentListScreen extends StatefulWidget {
  final String moduleId;
  final String moduleName;
  const ContentListScreen({
    Key? key,
    required this.moduleId,
    required this.moduleName,
  }) : super(key: key);

  @override
  _ContentListScreenState createState() => _ContentListScreenState();
}

class _ContentListScreenState extends State<ContentListScreen> {
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
                  widget.moduleName,
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
              return ContentCard(
                  contentId: "1", contentName: "Semi Conductors");
            },
          ),
        ],
      ),
    );
  }
}
