import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:studify/services/firebase/degrees/change_student_score.dart';
import 'package:studify/services/firebase/degrees/get_one_student_degrees.dart';
part 'degrees_event.dart';
part 'degrees_state.dart';

class DegreesBloc extends Bloc<DegreesEvent, DegreesState> {
  DegreesBloc() : super(DegreesInitial()) {
    on<GetStudentDegrees>(getStudentDegreesFun);
    on<ChangeStudentDegrees>(changeStudentDegreesFun);
  }

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
            .where((element) => element
                .toString()
                .toLowerCase()
                .contains(event.searchQuery.toLowerCase()))
            .toList();
        emit(DegreesLoaded(studentScoresInEvents));
      }
    } catch (e) {
      emit(DegreesError(e.toString()));
    }
  }

  FutureOr<void> changeStudentDegreesFun(
      ChangeStudentDegrees event, Emitter<DegreesState> emit) async {
    try {
      await changeStudentScore(
          event.classId, event.studentId, event.newScore, event.eventId);
    } catch (e) {
      emit(DegreesError(e.toString()));
    }
  }
}