part of 'working_cubit.dart';

@immutable
abstract class WorkingState {}

class WorkingInitial extends WorkingState {}

class WorkingEnded extends WorkingState {
  final EndTabArgs args;
  WorkingEnded({
    required this.args,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkingEnded && other.args == args;
  }

  @override
  int get hashCode => args.hashCode;

  @override
  String toString() => 'WorkingEnded(args: $args)';
}

class WorkingContentCompleted extends WorkingState {}

class WorkingContentNotCompleted extends WorkingState {}
