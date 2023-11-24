part of 'student_bloc.dart';

sealed class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class AddStudentEvent extends StudentEvent {
  String studentName;

  AddStudentEvent({
    required this.studentName,
  });
}
