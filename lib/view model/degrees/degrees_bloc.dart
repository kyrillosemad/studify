import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/services/firebase/degrees/get_one_student_degrees.dart';
part 'degrees_event.dart';
part 'degrees_state.dart';

class DegreesBloc extends Bloc<DegreesEvent, DegreesState> {
  DegreesBloc() : super(DegreesInitial()) {
    on<GetStudentDegrees>(getStudentDegreesFun);

  }
  var studentName = Get.arguments['studentName'];
  var studentId = Get.arguments['studentId'];
  var classId = Get.arguments['classId'];
  TextEditingController searchCont = TextEditingController();
  FutureOr<void> getStudentDegreesFun(
      GetStudentDegrees event, Emitter<DegreesState> emit) async {
    emit(DegreesLoading());
    try {
      var result = await getStudentScoresAndTotalInEvents(
          event.classId, event.studentId);
      List<Map<String, dynamic>> studentScoresInEvents =
          result['studentScoresInEvents'] as List<Map<String, dynamic>>;

      if (event.searchQuery.isEmpty) {
        emit(DegreesLoaded(studentScoresInEvents));
      } else {
        studentScoresInEvents = studentScoresInEvents
            .where((element) => element['eventName']
                .toString()
                .toLowerCase()
                .startsWith(event.searchQuery))
            .toList();
        emit(DegreesLoaded(studentScoresInEvents));
      }
    } catch (e) {
      emit(DegreesError(e.toString()));
    }
  }


}
