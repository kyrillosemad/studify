part of 'events_bloc.dart';

sealed class EventsState {}

class EventsInitial extends EventsState {}

class EventsLoading extends EventsState {}

class QuizLoaded extends EventsState {
  final List<Map<String, dynamic>> quizData;

  QuizLoaded(this.quizData);
}

class EventsLoaded extends EventsState {
  final List events;

  EventsLoaded(this.events);
}

class EventsError extends EventsState {
  final String msg;

  EventsError(this.msg);
}
