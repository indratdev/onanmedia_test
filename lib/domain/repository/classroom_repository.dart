import 'package:dartz/dartz.dart';
import 'package:onanmedia_test/data/services/fire_service.dart';

class ClassRoomRepository {
  final FireService fireService = FireService();

  Future<Either<String, String>> createClassRoom(
      String classRoomName, String addBy) async {
    return await fireService.createClassRoom(classRoomName, addBy);
  }
}
