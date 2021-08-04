import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/data/models/question_model.dart';
import 'package:my_lms/logic/cubit/quiz_card_cubit/quiz_card_cubit.dart';
import 'package:my_lms/logic/cubit/quiz_screen_cubit/quiz_screen_cubit.dart';
import 'package:my_lms/logic/cubit/select_answer_cubit/select_answer_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:my_lms/presentation/screens/widgets/quiz_card.dart';
import 'package:sizer/sizer.dart';

class QuizScreen extends StatefulWidget {
  final String moduleId;
  final String moduleName;
  const QuizScreen({
    Key? key,
    required this.moduleId,
    required this.moduleName,
  }) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<QuizScreenCubit>(context)
        .loadQuizList(moduleId: widget.moduleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.backgroundWhite,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 2.h,
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
                    Text(
                      "Questions",
                      style: TextStyle(
                          color: MyColors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              BlocBuilder<QuizScreenCubit, QuizScreenState>(
                builder: (context, state) {
                  if (state is QuizScreenInitial) {
                    return Text("Initial State");
                  } else if (state is QuizScreenLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is QuizScreenLoaded) {
                    return ListView.builder(
                        padding: EdgeInsets.all(0),
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.quizList.length,
                        itemBuilder: (context, index) {
                          Question question = state.quizList[index];
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => QuizCardCubit(),
                              ),
                              BlocProvider(
                                create: (context) => SelectAnswerCubit(),
                              )
                            ],
                            child: QuizCard(
                              index: index + 1,
                              question: question,
                            ),
                          );
                        });
                  } else if (state is QuizScreenNoResults) {
                    return Center(child: ErrorMsgBox(errorMsg: state.message));
                  } else if (state is QuizScreenFailed) {
                    return Center(
                        child: ErrorMsgBox(errorMsg: state.errorMessage));
                  } else {
                    return Center(
                      child:
                          ErrorMsgBox(errorMsg: "unhandled state excecuted!"),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
