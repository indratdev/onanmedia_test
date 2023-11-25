part of 'student_bloc.dart';

sealed class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class AddStudentEvent extends StudentEvent {
  StudentModel studentModel;

  AddStudentEvent({
    required this.studentModel,
  });
}

class UpdateStudentEvent extends StudentEvent {
  String id;
  StudentModel studentModel;

  UpdateStudentEvent({
    required this.id,
    required this.studentModel,
  });
}

class DeleteStudentEvent extends StudentEvent {
  String id;

  DeleteStudentEvent({
    required this.id,
  });
}
