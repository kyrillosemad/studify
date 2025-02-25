// all_events_event.dart
// ignore_for_file: prefer_typing_uninitialized_variables

part of 'my_events_bloc.dart';

sealed class MyEventsEvent {}

class GetEvents extends MyEventsEvent {
  final String classId;
  final String searchQuery;
  GetEvents(this.classId, this.searchQuery);
}

class GetEventParticipants extends MyEventsEvent {
  final String classId;
  final String eventId;
  GetEventParticipants(this.classId, this.eventId);
}

class DeleteEvent extends MyEventsEvent {
  final String classId;
  final String eventId;

  DeleteEvent(this.classId, this.eventId);
}



class GoToOneEvent extends MyEventsEvent {
  String eventName;
  String eventId;
  var eventDate;
  String classId;
  var totalScore;
  var studentScores;

  GoToOneEvent(this.classId, this.eventDate, this.eventId, this.eventName,
      this.totalScore, this.studentScores);
}
