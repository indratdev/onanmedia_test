import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onanmedia_test/data/models/student_model.dart';
import 'package:onanmedia_test/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:onanmedia_test/widgets/general_widget.dart';

import '../../../data/services/fire_query.dart';
import '../../../shared/utils/global_variables.dart';
import '../../../shared/utils/validator.dart';

class StudentManageScreen extends StatefulWidget {
  StudentManageScreen({
    super.key,
    this.data,
  });

  QueryDocumentSnapshot<Map<String, dynamic>>? data;

  @override
  State<StudentManageScreen> createState() => _StudentManageScreenState();
}

class _StudentManageScreenState extends State<StudentManageScreen> {
  final _formKeyUserManage = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? selectedValue;
  late Future<List<String>> dropdownData;

  @override
  void initState() {
    dropdownData = fetchDataFromFirebase();
    initUpdateData();
    super.initState();
  }

  initUpdateData() {
    if (widget.data != null) {
      fullnameController.text = widget.data?.data()["fullname"];
      nimController.text = widget.data?.data()["nim"];
      addressController.text = widget.data?.data()["address"];
    }
  }

  @override
  void dispose() {
    fullnameController.dispose();
    nimController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<List<String>> fetchDataFromFirebase() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FireQuery()
        .readClassRoom(FirebaseAuth.instance.currentUser?.email ?? "")
        .first;

    List<String> data = querySnapshot.docs
        .map((doc) => doc.data()['classRoom_Name'] as String)
        .toList();

    if (widget.data != null) {
      selectedValue = widget.data?.data()["className"];
    } else {
      selectedValue = data.first;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MAHASISWA"),
        centerTitle: true,
        elevation: 12,
        actions: [
          (widget.data != null)
              ? IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red.shade300,
                    size: MediaQuery.sizeOf(context).width / 13,
                  ),
                  onPressed: () {
                    BlocProvider.of<StudentBloc>(context)
                        .add(DeleteStudentEvent(id: widget.data!.id));
                  },
                )
              : const SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: BlocListener<StudentBloc, StudentState>(
            listener: (context, state) {
              if (state is LoadingDeleteStudent) {
                GeneralWidgets.showLoadingWidgetContainer(context);
              }

              if (state is LoadingUpdateStudent) {
                GeneralWidgets.showLoadingWidgetContainer(context);
              }

              if (state is LoadingAddStudent) {
                GeneralWidgets.showLoadingWidgetContainer(context);
              }

              if (state is FailureDeleteStudent) {
                GeneralWidgets.showMessageAlert(
                    context, state.messageError, false);
              }
              if (state is FailureAddStudent) {
                GeneralWidgets.showMessageAlert(
                    context, state.messageError, false);
              }

              if (state is FailureUpdateStudent) {
                GeneralWidgets.showMessageAlert(
                    context, state.messageError, false);
              }

              if (state is SuccessAddStudent) {
                GeneralWidgets.showMessageAlert(context, state.result, true);
              }

              if (state is SuccessUpdateStudent) {
                GeneralWidgets.showMessageAlert(context, state.result, true);
              }

              if (state is SuccessDeleteStudent) {
                GeneralWidgets.showMessageAlert(context, state.result, true);
              }
            },
            child: Form(
              key: _formKeyUserManage,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      validator: (value) =>
                          Validator.rule(value, required: true),
                      controller: fullnameController,
                      decoration: const InputDecoration(
                        label: Text("Nama Lengkap"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: nimController,
                      validator: (value) =>
                          Validator.rule(value, required: true),
                      decoration: const InputDecoration(
                        label: Text("NIM"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: addressController,
                      validator: (value) =>
                          Validator.rule(value, required: true),
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        label: Text("Alamat"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: StreamBuilder(
                      stream: FireQuery().readClassRoom(
                          FirebaseAuth.instance.currentUser?.email ?? ""),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator.adaptive();
                        }

                        List<String> itemNames = snapshot.data!.docs
                            .map((doc) => doc['classRoom_Name'] as String)
                            .toList();

                        return DropdownButtonFormField<String>(
                          isExpanded: true,
                          elevation: 12,
                          borderRadius: BorderRadius.circular(8),
                          itemHeight: MediaQuery.sizeOf(context).height / 15,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          value:
                              selectedValue, // Initially, no item is selected
                          onChanged: (String? selectedItem) {
                            setState(() {
                              selectedValue = selectedItem;
                            });
                          },
                          items: itemNames.map((String itemName) {
                            return DropdownMenuItem<String>(
                              value: itemName,
                              child: Text(itemName),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height / 18,
                          width: MediaQuery.sizeOf(context).width / 3,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "BATAL",
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height / 18,
                          width: MediaQuery.sizeOf(context).width / 3,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: GlobalVariables.baseColor,
                              elevation: 12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              (widget.data != null) ? "UPDATE" : "SIMPAN",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (_formKeyUserManage.currentState!.validate()) {
                                StudentModel data = StudentModel(
                                  fullname: fullnameController.text.trim(),
                                  nim: nimController.text.trim(),
                                  address: addressController.text.trim(),
                                  className: selectedValue!,
                                );

                                if (widget.data != null) {
                                  //update
                                  BlocProvider.of<StudentBloc>(context)
                                      .add(UpdateStudentEvent(
                                    id: widget.data!.id,
                                    studentModel: data,
                                  ));
                                } else {
                                  // create new
                                  BlocProvider.of<StudentBloc>(context)
                                      .add(AddStudentEvent(studentModel: data));
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
