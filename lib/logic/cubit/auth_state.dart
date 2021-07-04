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

class AuthSucceed extends AuthState {}

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

class AuthInvalidValue extends AuthState {
  final String errorMsg;
  AuthInvalidValue({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthInvalidValue && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
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
