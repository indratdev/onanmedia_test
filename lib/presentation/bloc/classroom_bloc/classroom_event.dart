part of 'classroom_bloc.dart';

sealed class ClassroomEvent extends Equatable {
  const ClassroomEvent();

  @override
  List<Object> get props => [];
}

class AddClassRoomEvent extends ClassroomEvent {
  String classRoomName;

  AddClassRoomEvent({
    required this.classRoomName,
  });
}
