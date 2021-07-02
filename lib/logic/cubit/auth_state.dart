part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSucceed extends AuthState {
  final User user;
  AuthSucceed({
    required this.user,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthSucceed && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class AuthCheckUserStatus extends AuthState {
  final bool userStatus;
  AuthCheckUserStatus({
    required this.userStatus,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthCheckUserStatus && other.userStatus == userStatus;
  }

  @override
  int get hashCode => userStatus.hashCode;
}

class AuthFailed extends AuthState {
  final String errorMsg;
  AuthFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}
