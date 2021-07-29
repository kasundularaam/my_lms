import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';

part 'h_t_c_item_state.dart';

class HTCItemCubit extends Cubit<HTCItemState> {
  HTCItemCubit() : super(HTCItemInitial());

  Future<void> loadSubjectDetails({required String subjectId}) async {
    try {
      emit(HTCItemLoading());
      int contentCount = 3;
      int fireContentCount =
          await FirebaseRepo.getCompltedContentCount(subjectId: subjectId);
      emit(HTCItemLoaded(
          contentCount: contentCount, fireContentCount: fireContentCount));
    } catch (e) {
      emit(HTCItemFailed(errorMsg: "--"));
    }
  }
}
