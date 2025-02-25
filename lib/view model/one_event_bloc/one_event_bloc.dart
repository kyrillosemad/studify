import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/services/firebase/degrees/change_student_score.dart';

part 'one_event_event.dart';
part 'one_event_state.dart';

class OneEventBloc extends Bloc<OneEventEvent, OneEventState> {
  OneEventBloc() : super(OneEventInitial()) {
    searchCont.addListener(() {
      searchStreamController.add(searchCont.text);
    });

    totalScoreCont.text = totalScore.toString();
    on<ChangeStudentDegrees>(_changeStudentDegrees);
  }

  String eventName = Get.arguments['eventName'];
  var eventDate = Get.arguments['eventDate'];
  var eventId = Get.arguments['eventId'];
  var classId = Get.arguments['classId'];
  var totalScore = Get.arguments['totalScore'];

  TextEditingController searchCont = TextEditingController();
  StreamController<String> searchStreamController =
      StreamController<String>.broadcast();
  TextEditingController newScoreCont = TextEditingController();
  TextEditingController totalScoreCont = TextEditingController();

  @override
  Future<void> close() {
    searchStreamController.close();
    searchCont.dispose();
    newScoreCont.dispose();
    totalScoreCont.dispose();
    return super.close();
  }

  FutureOr<void> _changeStudentDegrees(
      ChangeStudentDegrees event, Emitter<OneEventState> emit) async {
    try {
      await changeStudentScore(
          event.classId, event.studentId, event.newScore, event.eventId);
    } catch (e) {
      throw Exception();
    }
  }
}
