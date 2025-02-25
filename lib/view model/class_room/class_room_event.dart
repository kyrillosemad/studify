// ignore_for_file: must_be_immutable

part of 'class_room_bloc.dart';

@immutable
sealed class ClassRoomEvent {}

class DeleteClassForDoctorEvent extends ClassRoomEvent {}

class CheckAllowed extends ClassRoomEvent {}

class LeaveClassForStudent extends ClassRoomEvent {
  String classId;
  LeaveClassForStudent(this.classId);
}

class GoToOneStudentDegree extends ClassRoomEvent {}

class GoToEnrollInAbsence extends ClassRoomEvent {}

class GoToData extends ClassRoomEvent {}

class GoToQuiz extends ClassRoomEvent {}

class GoToChatRoom extends ClassRoomEvent {}
