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

// add new
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
//--

// update
class LoadingUpdateStudent extends StudentState {}

class FailureUpdateStudent extends FailureState {
  FailureUpdateStudent({required super.messageError});
}

class SuccessUpdateStudent extends StudentState {
  // User result;
  String result;

  SuccessUpdateStudent({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
//--

// update
class LoadingDeleteStudent extends StudentState {}

class FailureDeleteStudent extends FailureState {
  FailureDeleteStudent({required super.messageError});
}

class SuccessDeleteStudent extends StudentState {
  String result;

  SuccessDeleteStudent({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
//--