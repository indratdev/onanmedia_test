import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:onanmedia_test/data/models/student_model.dart';

class FireService {
  static const String classRoomCollection = "classrooms";
  static const String studentCollection = "students";

  // create Classroom
  Future<Either<String, String>> createClassRoom(
    String classRoomName,
    String addby,
  ) async {
    late Either<String, String> myEither;

    await FirebaseFirestore.instance
        .collection(classRoomCollection)
        .doc()
        .set({
          "classRoom_Name": classRoomName,
          "addBy": addby,
        })
        .then((value) => myEither = const Right("Kelas berhasil ditambahkan"))
        .catchError((e) => myEither = Left(e.toString()));

    return myEither;
  }

  // create Classroom
  Future<Either<String, String>> createStudent(
    StudentModel studentModel,
  ) async {
    late Either<String, String> myEither;

    await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc()
        .set(studentModel.toJson())
        .then((value) =>
            myEither = const Right("Data mahasiswa berhasil ditambahkan"))
        .catchError((e) => myEither = Left(e.toString()));

    return myEither;
  }

  // update student
  Future<Either<String, String>> updateStudent(
    String id,
    StudentModel studentModel,
  ) async {
    late Either<String, String> myEither;

    await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(id)
        .update(studentModel.toJson())
        .then((value) =>
            myEither = const Right("Perbaharui Data Mahasiswa Berhasil !"))
        .catchError((e) => myEither = Left(e.toString()));

    return myEither;
  }

  // delete student
  Future<Either<String, String>> deleteStudent(
    String documentID,
  ) async {
    late Either<String, String> myEither;
    await FirebaseFirestore.instance
        .collection(studentCollection)
        .doc(documentID)
        .delete()
        .then((value) => myEither = const Right("Hapus Mahasiswa Berhasil !"))
        .catchError((e) => myEither = Left(e.toString()));

    return myEither;
  }
}
