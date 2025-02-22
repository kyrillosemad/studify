part of 'participants_bloc.dart';

sealed class ParticipantsState {}

class ParticipantsInitial extends ParticipantsState {}

class ParticipantsLoading extends ParticipantsState {}

class ParticipantsLoaded extends ParticipantsState {
  final List<Map<String, dynamic>> participants;
  ParticipantsLoaded(this.participants);
}

class ParticipantsError extends ParticipantsState {
  final String msg;
  ParticipantsError(this.msg);
}
