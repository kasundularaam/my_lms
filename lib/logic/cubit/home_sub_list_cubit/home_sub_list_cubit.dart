import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/models/home_sub_card_model.dart';

part 'home_sub_list_state.dart';

class HomeSubListCubit extends Cubit<HomeSubListState> {
  HomeSubListCubit() : super(HomeSubListInitial());

  Future<void> getSubjectList() async {}
}
