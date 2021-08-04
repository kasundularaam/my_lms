import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/models/fire_user_model.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';

part 'profile_top_card_state.dart';

class ProfileTopCardCubit extends Cubit<ProfileTopCardState> {
  ProfileTopCardCubit() : super(ProfileTopCardInitial());

  Future<void> getUserDetails() async {
    try {
      emit(ProfileTopCardLoading());
      FireUser fireUser = await FirebaseRepo.getUserDetails();
      emit(ProfileTopCardLoaded(fireUser: fireUser));
    } catch (e) {
      emit(ProfileTopCardFailed(errorMsg: e.toString()));
    }
  }
}
