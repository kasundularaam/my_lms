import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/core/my_enums.dart';
import 'package:my_lms/data/models/subject_model.dart';
import 'package:my_lms/logic/cubit/auth_cubit.dart';
import 'package:my_lms/logic/cubit/authscreen_nav_cubit.dart';
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
    BlocProvider.of<AuthCubit>(context).loadInitState();
  }

  List<String> subjectList = [];
  @override
  Widget build(BuildContext context) {
    return ListView(
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
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 5.w,
                ),
                SelectSubjectCard(
                  subject: Subject(id: "1", name: "maths"),
                  isSelected: (subjectId) {
                    if (subjectList.contains(subjectId)) {
                      subjectList.remove(subjectId);
                    } else {
                      subjectList.add(subjectId);
                    }
                    print(subjectList);
                  },
                ),
                SelectSubjectCard(
                  subject: Subject(id: "2", name: "physics"),
                  isSelected: (subjectId) {
                    if (subjectList.contains(subjectId)) {
                      subjectList.remove(subjectId);
                    } else {
                      subjectList.add(subjectId);
                    }
                    print(subjectList);
                  },
                ),
                SelectSubjectCard(
                  subject: Subject(id: "3", name: "ict"),
                  isSelected: (subjectId) {
                    if (subjectList.contains(subjectId)) {
                      subjectList.remove(subjectId);
                    } else {
                      subjectList.add(subjectId);
                    }
                    print(subjectList);
                  },
                ),
                SelectSubjectCard(
                  subject: Subject(id: "4", name: "chemestry"),
                  isSelected: (subjectId) {
                    if (subjectList.contains(subjectId)) {
                      subjectList.remove(subjectId);
                    } else {
                      subjectList.add(subjectId);
                    }
                    print(subjectList);
                  },
                ),
                SelectSubjectCard(
                  subject: Subject(id: "5", name: "bio"),
                  isSelected: (subjectId) {
                    if (subjectList.contains(subjectId)) {
                      subjectList.remove(subjectId);
                    } else {
                      subjectList.add(subjectId);
                    }
                    print(subjectList);
                  },
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.w,
        ),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSucceed) {
              BlocProvider.of<AuthscreenNavCubit>(context)
                  .authNavigate(authNav: AuthNav.toAuthPage);
            }
          },
          builder: (context, state) {
            if (state is AuthInitial) {
              return buildInitialState();
            } else if (state is AuthLoading) {
              return buildLoadingState();
            } else if (state is AuthFailed) {
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
      onPressed: () => BlocProvider.of<AuthCubit>(context)
          .updateSubjectList(subjectList: subjectList),
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
          onPressed: () => BlocProvider.of<AuthCubit>(context)
              .updateSubjectList(subjectList: subjectList),
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
      height: 8.h,
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
