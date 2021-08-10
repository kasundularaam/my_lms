part of 'add_event_cal_cubit.dart';

@immutable
abstract class AddEventCalState {}

class AddEventCalInitial extends AddEventCalState {}

class AddEventCalLoading extends AddEventCalState {}

class AddEventCalSucceed extends AddEventCalState {}

class AddEventCalFailed extends AddEventCalState {
  final String errorMsg;
  AddEventCalFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddEventCalFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'AddEventCalFailed(errorMsg: $errorMsg)';
}
