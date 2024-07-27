part of 'participants_bloc.dart';

sealed class ParticipantsEvent {}

class FetchParticipants extends ParticipantsEvent {
  final String searchQuery;
  final String classId;
  FetchParticipants(this.classId, this.searchQuery);
}


class AddParticipants extends ParticipantsEvent {
  final String classId;
  final String studentId;
  final String studentName;
  AddParticipants(this.classId, this.studentId, this.studentName);
}

class DeleteParticipants extends ParticipantsEvent {
  final String classId;
  final String studentName;
  final String studentId;
  DeleteParticipants(this.classId, this.studentName, this.studentId);
}
