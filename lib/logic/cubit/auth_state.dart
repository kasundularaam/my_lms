part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  final String loadingMsg;
  AuthLoading({
    required this.loadingMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthLoading && other.loadingMsg == loadingMsg;
  }

  @override
  int get hashCode => loadingMsg.hashCode;
}

class AuthAppInitializeSucceed extends AuthState {
  final String succeedMsg;
  AuthAppInitializeSucceed({
    required this.succeedMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthAppInitializeSucceed && other.succeedMsg == succeedMsg;
  }

  @override
  int get hashCode => succeedMsg.hashCode;
}

class AuthSucceed extends AuthState {
  final LmsUser lmsUser;
  AuthSucceed({
    required this.lmsUser,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthSucceed && other.lmsUser == lmsUser;
  }

  @override
  int get hashCode => lmsUser.hashCode;
}

class AuthCheckUserStatus extends AuthState {
  final bool userStatus;
  final String statusMsg;
  AuthCheckUserStatus({
    required this.userStatus,
    required this.statusMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthCheckUserStatus &&
        other.userStatus == userStatus &&
        other.statusMsg == statusMsg;
  }

  @override
  int get hashCode => userStatus.hashCode ^ statusMsg.hashCode;
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
