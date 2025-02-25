import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:studify/services/firebase/events/add_event.dart';
import 'package:studify/services/firebase/events/enroll_in_absence.dart';
import 'package:studify/services/firebase/events/get_quiz.dart';
import 'package:studify/services/firebase/events/quiz_result.dart';
part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventsInitial()) {
    on<AddEvent>(addEventFun);
    on<EnrollInAbsence>(enrollInAbsenceFun);
    on<GetQuiz>(getQuizFun);
    on<QuizResult>(quizResultFun);
  }

  FutureOr<void> addEventFun(AddEvent event, Emitter<EventsState> emit) async {
    try {
      emit(EventsLoading());
      await addEvent(event.classId, event.eventName, event.eventId,
          event.totalScore, event.questions);
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }

  FutureOr<void> enrollInAbsenceFun(
      EnrollInAbsence event, Emitter<EventsState> emit) async {
    try {
      await enrollInAbsence(
          event.classId, event.eventId, event.studentName, event.studentId);
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }

  FutureOr<void> getQuizFun(GetQuiz event, Emitter<EventsState> emit) async {
    emit(EventsLoading());
    try {
      List<Map<String, dynamic>> quizQuestions =
          await getQuiz(event.classId, event.eventId);
      emit(QuizLoaded(quizQuestions));
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }

  FutureOr<void> quizResultFun(
      QuizResult event, Emitter<EventsState> emit) async {
    try {
      await quizResult(event.classId, event.eventId, event.userAnswers);
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }
}
