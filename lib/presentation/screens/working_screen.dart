import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/screen_arguments/end_tab_args.dart';
import 'package:my_lms/logic/cubit/timer_cubit/timer_cubit.dart';
import 'package:my_lms/logic/cubit/working_cubit/working_cubit.dart';
import 'package:my_lms/presentation/screens/working_tabs/congratulations_tab.dart';
import 'package:my_lms/presentation/screens/working_tabs/end_tab.dart';
import 'package:my_lms/presentation/screens/working_tabs/init_tab.dart';
import 'package:my_lms/core/screen_arguments/content_screen_args.dart';

class WorkingScreen extends StatefulWidget {
  final ContentScreenArgs args;
  const WorkingScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _WorkingScreenState createState() => _WorkingScreenState();
}

class _WorkingScreenState extends State<WorkingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkingCubit, WorkingState>(
      builder: (context, state) {
        if (state is WorkingInitial) {
          return BlocProvider(
            create: (context) => TimerCubit(),
            child: InitTab(args: widget.args),
          );
        } else if (state is WorkingEnded) {
          return EndTab(
            args: state.args,
          );
        } else if (state is WorkingContentCompleted) {
          return CongratulationsTab();
        } else if (state is WorkingContentNotCompleted) {
          Navigator.pop(context);
          return Scaffold();
        } else {
          return Scaffold();
        }
      },
    );
  }
}
