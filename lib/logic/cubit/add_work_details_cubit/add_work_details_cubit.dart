import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/core/screen_arguments/end_tab_args.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';

part 'add_work_details_state.dart';

class AddWorkDetailsCubit extends Cubit<AddWorkDetailsState> {
  AddWorkDetailsCubit() : super(AddWorkDetailsInitial());

  Future<void> addWorkDetails(
      {required bool isCompleted, required EndTabArgs endTabArgs}) async {
    try {
      emit(AddWorkDetailsLoading());
      await FirebaseRepo.addWorkDetails(
          isCompleted: isCompleted, endTabArgs: endTabArgs);
      emit(AddWorkDetailsSucceed(isCompleted: isCompleted));
    } catch (e) {
      emit(AddWorkDetailsFailed(errorMsg: e.toString()));
    }
  }
}
