import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onanmedia_test/repository/classroom_repository.dart';

part 'classroom_event.dart';
part 'classroom_state.dart';

class ClassroomBloc extends Bloc<ClassroomEvent, ClassroomState> {
  final ClassRoomRepository classRoomRepository = ClassRoomRepository();
  ClassroomBloc() : super(ClassroomInitial()) {
    on<AddClassRoomEvent>((event, emit) async {
      emit(LoadingAddClassRoom());

      try {
        String addBy = FirebaseAuth.instance.currentUser?.email ?? "";
        Either<String, String> result = await classRoomRepository
            .createClassRoom(event.classRoomName, addBy);
        result.fold(
            (err) => emit(FailureAddClassRoom(messageError: err.toString())),
            (data) => emit(SuccessAddClassRoom(result: data)));
      } catch (e) {
        emit(FailureAddClassRoom(messageError: e.toString()));
      }
    });
  }
}
