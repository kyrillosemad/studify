part of 'degrees_bloc.dart';

sealed class DegreesEvent {}



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