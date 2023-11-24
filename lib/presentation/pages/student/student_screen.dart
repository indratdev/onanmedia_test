import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onanmedia_test/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:onanmedia_test/presentation/pages/student/student_manage_screen.dart';

import '../../../data/services/fire_query.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MAHASISWA"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StudentManageScreen(),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener<StudentBloc, StudentState>(
          listener: (context, state) {
            if (state is LoadingAddStudent) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 120),
                      child: Dialog(
                        insetPadding: EdgeInsets.zero,
                        clipBehavior: Clip.antiAliasWithSaveLayer,

                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8.0)), //this right here
                        child: Container(
                          height: MediaQuery.of(context).size.height / 8,
                          width: MediaQuery.of(context).size.width / 4,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator.adaptive(),
                              SizedBox(height: 15),
                              Text('Loading...'),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }

            if (state is FailureAddStudent) {
              showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                      ),
                      width: MediaQuery.sizeOf(context).width / 2,
                      height: MediaQuery.sizeOf(context).width / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(state.messageError),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2DBAB1)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            if (state is SuccessAddStudent) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                      ),
                      width: MediaQuery.sizeOf(context).width / 2,
                      height: MediaQuery.sizeOf(context).width / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(state.result),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2DBAB1)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
          child: StreamBuilder(
              stream: FireQuery().readStudent(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }

                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>? datas =
                      snapshot.data?.docs;

                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("Tidak ada data !"));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: datas?.length ?? 0,
                    itemBuilder: (context, index) {
                      Map<String, dynamic>? data = datas?[index].data();
                      return Container(
                        height: 80,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data?["classRoom_Name"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize:
                                      MediaQuery.sizeOf(context).width * 0.045),
                            ),
                            Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Container(
                    child: Text("No data"),
                  );
                }
              }),
        ),
      ),
    );
  }
}

class StudentAddWidget extends StatefulWidget {
  const StudentAddWidget({
    super.key,
  });

  @override
  State<StudentAddWidget> createState() => _StudentAddWidgetState();
}

class _StudentAddWidgetState extends State<StudentAddWidget> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text('Masukan Nama Kelas'),
              content: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Ketik nama kelas",
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('BATAL'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2DBAB1),
                  ),
                  onPressed: () {
                    String value = (nameController.text).trim();

                    if (value != "") {
                      print("jalan");
                      // BlocProvider.of<ClassroomBloc>(context)
                      //     .add(AddClassRoomEvent(classRoomName: value));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('SIMPAN'),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
