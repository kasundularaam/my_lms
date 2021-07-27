import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/data/models/fire_subject_model.dart';
import 'package:my_lms/logic/cubit/auth_nav_cubit/authscreen_nav_cubit.dart';
import 'package:my_lms/logic/cubit/select_sub_list_cubit/select_sub_list_cubit.dart';
import 'package:my_lms/logic/cubit/select_subject_cubit/select_subject_cubit.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/core/my_enums.dart';
import 'package:my_lms/data/models/subject_model.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:my_lms/presentation/screens/widgets/select_subject_card.dart';

class SelectSubjectPage extends StatefulWidget {
  const SelectSubjectPage({Key? key}) : super(key: key);

  @override
  _SelectSubjectPageState createState() => _SelectSubjectPageState();
}

class _SelectSubjectPageState extends State<SelectSubjectPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SelectSubListCubit>(context).loadSubjectList();
  }

  List<Subject> selectedList = [];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Container(
          height: 75.h,
          width: 100.w,
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
            child:
                BlocBuilder<SelectSubListCubit, SelectSubListState>(builder: (
              context,
              state,
            ) {
              if (state is SelectSubjectLoading) {
                return buildLoadingState();
              } else if (state is SelectSubjectLoaded) {
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Select your subjects",
                      style: TextStyle(
                          color: MyColors.accentColor,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: state.subjectList.length,
                        itemBuilder: (context, index) {
                          Subject subject = state.subjectList[index];
                          return SelectSubjectCard(
                              subject: subject,
                              isSelected: (subjectId) {
                                if (selectedList.contains(subjectId)) {
                                  selectedList.remove(subjectId);
                                } else {
                                  selectedList.add(subjectId);
                                }
                              });
                        }),
                  ],
                );
              } else if (state is SelectSubjectFailed) {
                return Center(child: ErrorMsgBox(errorMsg: state.errorMsg));
              } else {
                return Center(child: Text("unhandled state excecuted!"));
              }
            }),
          ),
        ),
        SizedBox(
          height: 5.w,
        ),
        BlocConsumer<SelectSubjectCubit, SelectSubjectState>(
          listener: (context, state) {
            if (state is SelectedSubjectSucceed) {
              BlocProvider.of<AuthscreenNavCubit>(context)
                  .authNavigate(authNav: AuthNav.toAuthPage);
            }
          },
          builder: (context, state) {
            if (state is SelectSubjectInitial) {
              return buildInitialState();
            } else if (state is SelectedSubjectLoading) {
              return buildLoadingState();
            } else if (state is SelectedSubjectFailed) {
              return buildFailedState(errorMsg: state.errorMsg);
            } else {
              return Center(child: Text("unhandled state excecuted!"));
            }
          },
        )
      ],
    );
  }

  Widget buildInitialState() {
    return CheckIconBtn(
      onPressed: () => BlocProvider.of<SelectSubjectCubit>(context)
          .updateSubjectList(subjectList: selectedList),
    );
  }

  Widget buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildFailedState({required String errorMsg}) {
    return Column(
      children: [
        ErrorMsgBox(errorMsg: errorMsg),
        SizedBox(
          height: 5.w,
        ),
        CheckIconBtn(
          onPressed: () => BlocProvider.of<SelectSubjectCubit>(context)
              .updateSubjectList(subjectList: selectedList),
        )
      ],
    );
  }
}

class CheckIconBtn extends StatelessWidget {
  final Function onPressed;
  const CheckIconBtn({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      child: Center(
        child: GestureDetector(
          onTap: () => onPressed(),
          child: Icon(
            Icons.check_circle,
            size: 8.h,
            color: MyColors.accentColor,
          ),
        ),
      ),
    );
  }
}
