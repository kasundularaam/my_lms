import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/core/screen_arguments/content_screen_args.dart';
import 'package:my_lms/core/screen_arguments/end_tab_args.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerInitial(initCounter: "00:00:00"));

  int counter = 0;
  String timeString = "00:00:00";
  String hoursStr = "";
  String minutesStr = "";
  String secondsStr = "";
  int startTimestamp = 0;
  int endTimestamp = 0;
  Timer? _myTimer;
  Duration timerInterval = Duration(seconds: 1);

  void startTimer() {
    startTimestamp = DateTime.now().millisecondsSinceEpoch;
    emit(TimerStarted(startedCounter: "00:00:00"));
    _myTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      counter++;
      hoursStr =
          ((counter / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
      minutesStr = ((counter / 60) % 60).floor().toString().padLeft(2, '0');
      secondsStr = (counter % 60).floor().toString().padLeft(2, '0');
      timeString = "$hoursStr" ":" "$minutesStr" ":" "$secondsStr";
      emit(TimerRunning(timeCounter: timeString));
    });
  }

  void endTimer({required ContentScreenArgs contentScreenArgs}) {
    if (_myTimer != null) {
      endTimestamp = DateTime.now().millisecondsSinceEpoch;
      _myTimer!.cancel();
      _myTimer = null;
      emit(
        TimerEnded(
          args: EndTabArgs(
            contentScreenArgs: contentScreenArgs,
            clockValue: timeString,
            startTimestamp: startTimestamp,
            endTimestamp: endTimestamp,
            counter: counter,
          ),
        ),
      );
    }
  }
}
