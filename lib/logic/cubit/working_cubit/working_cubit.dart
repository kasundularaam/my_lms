import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/core/screen_arguments/end_tab_args.dart';

part 'working_state.dart';

class WorkingCubit extends Cubit<WorkingState> {
  WorkingCubit() : super(WorkingInitial());
}
