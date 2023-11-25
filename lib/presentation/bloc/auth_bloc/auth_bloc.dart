import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/auth_service.dart';
import '../../../data/services/signsignup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoadingLogin());

      try {
        SignInSignUpResult result = await AuthServices.signInWithEmail(
          email: event.email,
          pass: event.password,
        );

        if (result.user != null) {
          emit(SuccessLogin(result: result.user!));
        } else {
          emit(FailureLogin(messageError: "Failed to login"));
        }
      } catch (e) {
        emit(FailureLogin(messageError: "Failed to login"));
      }
    });
  }
}
