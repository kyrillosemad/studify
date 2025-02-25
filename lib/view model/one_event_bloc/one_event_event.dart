part of 'one_event_bloc.dart';

sealed class OneEventEvent {}
class ChangeStudentDegrees extends OneEventEvent {
  final String classId;
  final String studentId;
  final String newScore;
  final String eventId;

  ChangeStudentDegrees(
      this.classId, this.studentId, this.newScore, this.eventId);
}

