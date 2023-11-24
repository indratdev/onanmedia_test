import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onanmedia_test/data/services/fire_service.dart';

class FireQuery {
  Stream<QuerySnapshot<Map<String, dynamic>>> readClassRoom(String addBy) {
    return FirebaseFirestore.instance
        .collection(FireService.classRoomCollection)
        .where('addBy', isEqualTo: addBy)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readStudent() {
    return FirebaseFirestore.instance
        .collection(FireService.studentCollection)
        // .where('addBy', isEqualTo: addBy)
        .snapshots();
  }
}
