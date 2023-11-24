part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class FailureState extends AuthState {
  String messageError;

  FailureState({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

class LoadingLogin extends AuthState {}

class FailureLogin extends FailureState {
  FailureLogin({required super.messageError});
}

class SuccessLogin extends AuthState {
  User result;

  SuccessLogin({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
