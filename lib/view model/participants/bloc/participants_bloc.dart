import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:studify/services/firebase/participants/add_participants.dart';
import 'package:studify/services/firebase/participants/delete_participant.dart';
import 'package:studify/services/firebase/participants/get_all_participants.dart';
part 'participants_event.dart';
part 'participants_state.dart';

class ParticipantsBloc extends Bloc<ParticipantsEvent, ParticipantsState> {
  ParticipantsBloc() : super(ParticipantsInitial()) {
    on<FetchParticipants>(fetchParticipantsFun);
    on<AddParticipants>(addParticipantsFun);
    on<DeleteParticipants>(deleteParticipantsFun);
  }

  FutureOr<void> fetchParticipantsFun(
      FetchParticipants event, Emitter<ParticipantsState> emit) async {
    emit(ParticipantsLoading());
    try {
      List<Map<String, dynamic>> participants =
          await getAllParticipants(event.classId);
      if (event.searchQuery.isEmpty) {
        emit(ParticipantsLoaded(participants));
      } else {
        String searchQueryLower = event.searchQuery.toLowerCase();
        List<Map<String, dynamic>> filteredParticipants = participants
            .where((element) =>
                element['studentName']
                    .toString()
                    .toLowerCase()
                    .contains(searchQueryLower) ||
                element['studentId']
                    .toString()
                    .toLowerCase()
                    .contains(searchQueryLower))
            .toList();
        emit(ParticipantsLoaded(filteredParticipants));
      }
    } catch (e) {
      emit(ParticipantsError(e.toString()));
    }
  }

  FutureOr<void> addParticipantsFun(
      AddParticipants event, Emitter<ParticipantsState> emit) async {
    try {
      emit(ParticipantsLoading());
      await addParticipant(event.classId, event.studentId, event.studentName);
      add(FetchParticipants(event.classId, ''));
    } catch (e) {
      emit(ParticipantsError(e.toString()));
    }
  }

  FutureOr<void> deleteParticipantsFun(
      DeleteParticipants event, Emitter<ParticipantsState> emit) async {
    try {
      emit(ParticipantsLoading());
      await deleteParticipant(
          event.classId, event.studentName, event.studentId);
      add(FetchParticipants(event.classId, ''));
    } catch (e) {
      emit(ParticipantsError(e.toString()));
    }
  }
}
