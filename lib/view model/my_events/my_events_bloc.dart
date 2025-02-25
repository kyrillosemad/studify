import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/services/firebase/events/delete_event.dart';
import 'package:studify/services/firebase/events/my_events.dart';
import 'package:studify/view/modules/class%20room/screens/event.dart';
part 'my_events_event.dart';
part 'my_events_state.dart';

class MyEventsBloc extends Bloc<MyEventsEvent, MyEventsState> {
  MyEventsBloc() : super(MyEventsInitial()) {
    on<GetEvents>(getEventsFun);
    on<DeleteEvent>(deleteEventFun);
    on<GoToOneEvent>(goToOneEvent);
  }
  var classId = Get.arguments['classId'];
  TextEditingController searchCont = TextEditingController();

  FutureOr<void> getEventsFun(
      GetEvents event, Emitter<MyEventsState> emit) async {
    emit(MYEventsLoading());
    try {
      List events = await getMyEvents(event.classId);
      if (event.searchQuery.isEmpty) {
        emit(MyEventsLoaded(events));
      } else {
        List filteredEvents = events
            .where((element) => element['eventName']
                .toString()
                .toLowerCase()
                .startsWith(event.searchQuery))
            .toList();
        emit(MyEventsLoaded(filteredEvents));
      }
    } catch (e) {
      emit(MyEventsError(e.toString()));
    }
  }

  FutureOr<void> deleteEventFun(
      DeleteEvent event, Emitter<MyEventsState> emit) async {
    try {
      emit(MYEventsLoading());
      await deleteEvent(event.classId, event.eventId);
      add(GetEvents(event.classId, ''));
    } catch (e) {
      emit(MyEventsError(e.toString()));
    }
  }

  FutureOr<void> goToOneEvent(GoToOneEvent event, Emitter<MyEventsState> emit) {
    Get.to(const EventPage(), arguments: {
      "eventName": event.eventName.toString(),
      "eventId": event.eventId.toString(),
      "eventDate": event.eventDate.toString(),
      "studentsScores": event.studentScores.toString(),
      "classId": classId.toString(),
      "totalScore": event.totalScore.toString()
    });
  }
}
