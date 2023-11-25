import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onanmedia_test/data/services/fire_query.dart';
import 'package:onanmedia_test/presentation/bloc/classroom_bloc/classroom_bloc.dart';
import 'package:onanmedia_test/presentation/pages/classroom/widgets/classroom_add_widget.dart';

class ClassRoomScreen extends StatelessWidget {
  const ClassRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KELAS"),
        centerTitle: true,
      ),
      floatingActionButton: ClassRoomAddWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener<ClassroomBloc, ClassroomState>(
          listener: (context, state) {
            if (state is LoadingAddClassRoom) {
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

            if (state is FailureAddClassRoom) {
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

            if (state is SuccessAddClassRoom) {
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
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>? datas =
                      snapshot.data?.docs;

                  if (datas?.length == 0) {
                    return const Center(child: Text("Tidak Ada Data !"));
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
                            const Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("Tidak Ada Data !"));
                }
              }),
        ),
      ),
    );
  }
}
