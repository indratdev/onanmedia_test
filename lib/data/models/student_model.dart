import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  String fullname;
  String nim;
  String address;
  String className;

  StudentModel({
    required this.fullname,
    required this.nim,
    required this.address,
    required this.className,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        fullname: json['fullname'] as String? ?? "",
        nim: json['nim'] as String? ?? "",
        address: json['address'] as String? ?? "",
        className: json['className'] as String? ?? "",
      );

  Map<String, dynamic> toJson() => {
        'fullname': fullname,
        'nim': nim,
        'address': address,
        'className': className,
      };

  StudentModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : fullname = doc.data()!["fullname"],
        nim = doc.data()!["nim"],
        address = doc.data()!["address"],
        className = doc.data()!["className"];
}
