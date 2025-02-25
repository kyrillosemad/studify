part of 'events_bloc.dart';

sealed class EventsEvent {}

class AddEvent extends EventsEvent {
  final String classId;
  final String eventName;
  final String eventId;
  final String totalScore;
  final List questions;

  AddEvent(this.classId, this.eventName, this.eventId, this.totalScore,
      this.questions);
}

class EnrollInAbsence extends EventsEvent {
  final String classId;
  final String eventId;
  final String studentName;
  final String studentId;

  EnrollInAbsence(this.classId, this.eventId, this.studentName, this.studentId);
}

class GetQuiz extends EventsEvent {
  final String classId;
  final String eventId;

  GetQuiz(this.classId, this.eventId);
}

class QuizResult extends EventsEvent {
  final String classId;
  final String eventId;
  final String userAnswers;

  QuizResult(this.classId, this.eventId, this.userAnswers);
}

class RemoveQuestion extends EventsEvent {
  final int index;
  RemoveQuestion(this.index);
}

class AddQuestion extends EventsEvent {}
