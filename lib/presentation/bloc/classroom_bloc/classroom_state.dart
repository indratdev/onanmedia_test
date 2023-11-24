part of 'classroom_bloc.dart';

sealed class ClassroomState extends Equatable {
  const ClassroomState();

  @override
  List<Object> get props => [];
}

final class ClassroomInitial extends ClassroomState {}

class FailureState extends ClassroomState {
  String messageError;

  FailureState({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

class LoadingAddClassRoom extends ClassroomState {}

class FailureAddClassRoom extends FailureState {
  FailureAddClassRoom({required super.messageError});
}

class SuccessAddClassRoom extends ClassroomState {
  // User result;
  String result;

  SuccessAddClassRoom({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
