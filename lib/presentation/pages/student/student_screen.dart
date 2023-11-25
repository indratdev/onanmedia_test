import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onanmedia_test/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:onanmedia_test/presentation/pages/student/student_manage_screen.dart';
import 'package:onanmedia_test/widgets/general_widget.dart';

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
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentManageScreen(),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("Tidak ada data !"));
                }

                List<QueryDocumentSnapshot<Map<String, dynamic>>>? datas =
                    snapshot.data?.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: datas?.length ?? 0,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot<Map<String, dynamic>>? data =
                        datas?[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StudentManageScreen(data: data))),
                      child: Container(
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
                            Expanded(
                              child: ListTile(
                                dense: true,
                                title: Text(
                                  data?["fullname"],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: MediaQuery.sizeOf(context).width *
                                        0.045,
                                  ),
                                ),
                                subtitle: Text(
                                  data?["nim"],
                                ),
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text("Tidak Ada Data !"));
              }
            }),
        // ),
      ),
    );
  }
}
