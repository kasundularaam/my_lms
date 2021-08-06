import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/data/models/fire_content.dart';
import 'package:my_lms/logic/cubit/work_card_list_cubit/work_card_list_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:my_lms/presentation/screens/widgets/work_card.dart';

class WorkCardList extends StatelessWidget {
  const WorkCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WorkCardListCubit>(context).loadFireContentList();
    return BlocBuilder<WorkCardListCubit, WorkCardListState>(
      builder: (context, state) {
        if (state is WorkCardListInitial) {
          return Center(child: Text("Initial State"));
        } else if (state is WorkCardListLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: MyColors.progressColor,
            ),
          );
        } else if (state is WorkCardListLoaded) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.fireContents.length,
            itemBuilder: (BuildContext context, int index) {
              FireContent fireContent = state.fireContents[index];
              return WorkCard(fireContent: fireContent);
            },
          );
        } else if (state is WorkCardListFailed) {
          return Center(child: ErrorMsgBox(errorMsg: state.errorMsg));
        } else {
          return Center(
            child: ErrorMsgBox(
              errorMsg: "unhandled state excecuted!",
            ),
          );
        }
      },
    );
  }
}
