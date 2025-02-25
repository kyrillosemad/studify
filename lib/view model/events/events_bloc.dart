import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:studify/services/firebase/events/add_event.dart';
import 'package:studify/services/firebase/events/enroll_in_absence.dart';
import 'package:studify/services/firebase/events/get_quiz.dart';
import 'package:studify/services/firebase/events/quiz_result.dart';
import 'package:studify/view/modules/class%20room/widgets/quiz_qusetion_class.dart';
part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventsInitial()) {
    on<AddEvent>(addEventFun);
    on<EnrollInAbsence>(enrollInAbsenceFun);
    on<GetQuiz>(getQuizFun);
    on<QuizResult>(quizResultFun);
    on<RemoveQuestion>(removeQuestion);
    on<AddQuestion>(addQuestionFun);

    searchCont.addListener(() {
      searchStreamController.add(searchCont.text);
    });
  }
  var classId = Get.arguments['classId'];
  var eventId = Random().nextInt(10000000).toString();
  final quizFormKey = GlobalKey<FormState>();
  final absenceFormKey = GlobalKey<FormState>();
  final otherEventFormKey = GlobalKey<FormState>();
  TextEditingController quizNameCont = TextEditingController();
  TextEditingController quizScoreCont = TextEditingController();
  int numOfQuestions = 0;
  List<QuizQuestion> questions = [];

  bool isready = false;
  TextEditingController eventNameCont = TextEditingController();
  TextEditingController searchCont = TextEditingController();
  TextEditingController totalScoreCont = TextEditingController();
  TextEditingController newScoreCont = TextEditingController();
  StreamController<String> searchStreamController =
      StreamController<String>.broadcast();

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

  FutureOr<void> removeQuestion(
      RemoveQuestion event, Emitter<EventsState> emit) {
    questions.removeAt(event.index);
    numOfQuestions--;
    emit(EventsInitial());
  }

  FutureOr<void> addQuestionFun(AddQuestion event, Emitter<EventsState> emit) {
    numOfQuestions++;
    questions.add(QuizQuestion());
    emit(EventsInitial());
  }
}
