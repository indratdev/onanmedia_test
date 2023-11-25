import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onanmedia_test/data/models/student_model.dart';
import 'package:onanmedia_test/domain/repository/student_repository.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentRepository studentRepository = StudentRepository();

  StudentBloc() : super(StudentInitial()) {
    on<AddStudentEvent>((event, emit) async {
      emit(LoadingAddStudent());
      try {
        Either<String, String> result =
            await studentRepository.createStudent(event.studentModel);

        result.fold(
          (err) => emit(FailureAddStudent(messageError: err.toString())),
          (data) => emit(SuccessAddStudent(result: data)),
        );
      } catch (e) {
        emit(FailureAddStudent(messageError: e.toString()));
      }
    });

    on<UpdateStudentEvent>((event, emit) async {
      emit(LoadingUpdateStudent());
      try {
        Either<String, String> result =
            await studentRepository.updateStudent(event.id, event.studentModel);
        result.fold(
          (err) => emit(FailureUpdateStudent(messageError: err.toString())),
          (data) => emit(SuccessUpdateStudent(result: data)),
        );
      } catch (e) {
        emit(FailureUpdateStudent(messageError: e.toString()));
      }
    });

    on<DeleteStudentEvent>((event, emit) async {
      emit(LoadingDeleteStudent());
      try {
        Either<String, String> result =
            await studentRepository.deleteStudent(event.id);
        result.fold(
          (err) => emit(FailureDeleteStudent(messageError: err.toString())),
          (data) => emit(SuccessDeleteStudent(result: data)),
        );
      } catch (e) {
        emit(FailureDeleteStudent(messageError: e.toString()));
      }
    });
  }
}
