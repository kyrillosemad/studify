// all_events_state.dart
part of 'my_events_bloc.dart';

sealed class MyEventsState {}

class MyEventsInitial extends MyEventsState {}

class MYEventsLoading extends MyEventsState {}

class MyEventsLoaded extends MyEventsState {
  final List events;

  MyEventsLoaded(this.events);
}

class MyEventsError extends MyEventsState {
  final String msg;
 MyEventsError(this.msg);
}
