import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../data/services/fire_query.dart';
import '../../../shared/utils/validator.dart';

class StudentManageScreen extends StatefulWidget {
  const StudentManageScreen({super.key});

  @override
  State<StudentManageScreen> createState() => _StudentManageScreenState();
}

class _StudentManageScreenState extends State<StudentManageScreen> {
  final _formKeyUserManage = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? listClassRooms = [];
  QueryDocumentSnapshot<Map<String, dynamic>>? selectedClassRooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MAHASISWA"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: _formKeyUserManage,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    validator: (value) => Validator.rule(value, required: true),
                    controller: nameController,
                    decoration: const InputDecoration(
                      label: Text("Nama Lengkap"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: nimController,
                    decoration: const InputDecoration(
                      label: Text("NIM"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: addressController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      label: Text("Alamat"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: StreamBuilder(
                      stream: FireQuery().readClassRoom(
                          FirebaseAuth.instance.currentUser?.email ?? ""),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        }

                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        }

                        if (snapshot.hasData) {
                          List<QueryDocumentSnapshot<Map<String, dynamic>>>?
                              datas = snapshot.data?.docs;
                          listClassRooms = snapshot.data?.docs;

                          return DropdownButton(
                            isDense: true,
                            value:
                                listClassRooms?.first.data()["classRoom_Name"],
                            items: listClassRooms?.map((data) {
                              return DropdownMenuItem(
                                value: data.data()["classRoom_Name"],
                                child: Text(
                                  data.data()["classRoom_Name"],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                // selectedClassRooms = value;
                                print(">>> onghance : ${value}");
                              });
                            },
                          );

                          // return ListView.builder(
                          //   shrinkWrap: true,
                          //   itemCount: datas?.length ?? 0,
                          //   itemBuilder: (context, index) {
                          //     Map<String, dynamic>? data = datas?[index].data();
                          //     return Container(
                          //       height: 80,
                          //       margin: const EdgeInsets.symmetric(vertical: 8),
                          //       padding:
                          //           const EdgeInsets.symmetric(horizontal: 8),
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(8),
                          //         color: Colors.grey.shade200,
                          //       ),
                          //       child: Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text(
                          //             data?["classRoom_Name"],
                          //             maxLines: 2,
                          //             overflow: TextOverflow.ellipsis,
                          //             style: TextStyle(
                          //                 fontWeight: FontWeight.w500,
                          //                 fontSize:
                          //                     MediaQuery.sizeOf(context).width *
                          //                         0.045),
                          //           ),
                          //           Icon(Icons.arrow_forward_ios_rounded),
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // );
                        } else {
                          return Container(
                            child: Text("No data"),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
