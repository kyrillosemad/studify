part of 'degrees_bloc.dart';

sealed class DegreesEvent {}

class ChangeStudentDegrees extends DegreesEvent {
  final String classId;
  final String studentId;
  final String newScore;
  final String eventId;

  ChangeStudentDegrees(
      this.classId, this.studentId, this.newScore, this.eventId);
}

class GetStudentDegrees extends DegreesEvent {
  String classId;
  String studentId;
  String searchQuery;
  GetStudentDegrees(
    this.classId,
    this.studentId,
    this.searchQuery,
  );
}

class GetStudentsDegreesInEvent extends DegreesEvent {
  String searchQuery;
  String classId;
  String eventId;
  GetStudentsDegreesInEvent(this.classId, this.eventId, this.searchQuery);
}
