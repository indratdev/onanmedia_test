import 'package:dartz/dartz.dart';
import 'package:onanmedia_test/data/models/student_model.dart';
import 'package:onanmedia_test/data/services/fire_service.dart';

class StudentRepository {
  final FireService fireService = FireService();

  Future<Either<String, String>> createStudent(
      StudentModel studentModel) async {
    return await fireService.createStudent(studentModel);
  }

  Future<Either<String, String>> updateStudent(
      String id, StudentModel studentModel) async {
    return await fireService.updateStudent(id, studentModel);
  }

  Future<Either<String, String>> deleteStudent(String id) async {
    return await fireService.deleteStudent(id);
  }
}
