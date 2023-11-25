import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onanmedia_test/presentation/bloc/classroom_bloc/classroom_bloc.dart';

class ClassRoomAddWidget extends StatefulWidget {
  const ClassRoomAddWidget({
    super.key,
  });

  @override
  State<ClassRoomAddWidget> createState() => _ClassRoomAddWidgetState();
}

class _ClassRoomAddWidgetState extends State<ClassRoomAddWidget> {
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

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
                      backgroundColor: const Color(0xFF2DBAB1)),
                  onPressed: () {
                    setState(() {
                      String value = (nameController.text).trim();

                      if (value != "") {
                        BlocProvider.of<ClassroomBloc>(context)
                            .add(AddClassRoomEvent(classRoomName: value));
                        nameController.clear();
                        Navigator.pop(context);
                      }
                    });
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
