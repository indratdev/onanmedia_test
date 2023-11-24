part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  String email;
  String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}
