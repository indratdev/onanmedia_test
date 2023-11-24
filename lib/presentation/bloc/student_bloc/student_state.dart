part of 'student_bloc.dart';

sealed class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

final class StudentInitial extends StudentState {}

class FailureState extends StudentState {
  String messageError;

  FailureState({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

class LoadingAddStudent extends StudentState {}

class FailureAddStudent extends FailureState {
  FailureAddStudent({required super.messageError});
}

class SuccessAddStudent extends StudentState {
  // User result;
  String result;

  SuccessAddStudent({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
