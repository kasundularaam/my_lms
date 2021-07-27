import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/data/models/subject_model.dart';
import 'package:my_lms/logic/cubit/home_tab_cubit/home_tab_cubit.dart';
import 'package:my_lms/logic/cubit/subject_card_cubit/subject_card_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
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
  void initState() {
    super.initState();
    BlocProvider.of<HomeTabCubit>(context).loadSubjects();
  }

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
            BlocBuilder<HomeTabCubit, HomeTabState>(
              builder: (context, state) {
                if (state is HomeTabInitial) {
                  return Center(child: Text("Initial State"));
                } else if (state is HomeTabLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HomeTabLoaded) {
                  return ListView.builder(
                      padding: EdgeInsets.all(0),
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.subjectList.length,
                      itemBuilder: (context, index) {
                        Subject subject = state.subjectList[index];
                        return BlocProvider(
                          create: (context) => SubjectCardCubit(),
                          child: SubjectCard(subject: subject),
                        );
                      });
                } else if (state is HomeTabFailed) {
                  return Center(child: ErrorMsgBox(errorMsg: state.errorMsg));
                } else {
                  return Center(child: Text("unhandled state excecuted!"));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
