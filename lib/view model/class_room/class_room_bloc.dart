// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:studify/core/constants/shared.dart';
import 'package:studify/services/firebase/class/delete_class.dart';
import 'package:studify/services/firebase/events/allowed.dart';
import 'package:studify/services/firebase/events/enroll_in_absence.dart';
import 'package:studify/services/firebase/participants/delete_participant.dart';
import 'package:studify/view/modules/class%20room/screens/add_another_event.dart';
import 'package:studify/view/modules/class%20room/screens/chat_page.dart';
import 'package:studify/view/modules/class%20room/screens/data_for_doctor.dart';
import 'package:studify/view/modules/class%20room/screens/data_for_student.dart';
import 'package:studify/view/modules/class%20room/screens/make_quiz.dart';
import 'package:studify/view/modules/class%20room/screens/my_events.dart';
import 'package:studify/view/modules/class%20room/screens/one_student_degree.dart';
import 'package:studify/view/modules/class%20room/screens/participants.dart';
import 'package:studify/view/modules/class%20room/screens/quiz_page.dart';
import 'package:studify/view/modules/class%20room/screens/students_degrees.dart';
import 'package:studify/view/modules/class%20room/screens/take_absence.dart';
import 'package:studify/view/modules/main%20pages/screens/doctor_home_page.dart';
import 'package:studify/view/modules/main%20pages/screens/student_home_page.dart';

part 'class_room_event.dart';
part 'class_room_state.dart';

class _Service {
  final VoidCallback onTap;
  final Color color;
  final IconData icon;
  final String service;

  _Service({
    required this.onTap,
    required this.color,
    required this.icon,
    required this.service,
  });
}

class ClassRoomBloc extends Bloc<ClassRoomEvent, ClassRoomState> {
  ClassRoomBloc() : super(ClassRoomInitial()) {
    initServices();
    on<DeleteClassForDoctorEvent>(_deleteClassForDoctor);
    on<CheckAllowed>(_checkAllowed);
    on<LeaveClassForStudent>(_leaveClassForStudent);
    on<GoToOneStudentDegree>(_goToOneStudentDegree);
    on<GoToEnrollInAbsence>(_goToEnrollAbsence);
    on<GoToData>(_goToData);
    on<GoToQuiz>(_goToQuiz);
    on<GoToChatRoom>(_goToChatRoom);
  }

  late final String classId;
  late final String className;
  late final String date;
  bool isAllowed = false;
  TextEditingController quizIdCont = TextEditingController();
  late final List<_Service> services;

  void initServices() {
    classId = Get.arguments['classId'];
    className = Get.arguments['className'];
    date = Get.arguments['date'];

    services = [
      _Service(
        onTap: () =>
            Get.to(const Participants(), arguments: {"classId": classId}),
        color: Colors.green,
        icon: Icons.group,
        service: "Participants",
      ),
      _Service(
        onTap: () => Get.to(const MyEvents(), arguments: {"classId": classId}),
        color: Colors.amber,
        icon: Icons.event,
        service: "My events",
      ),
      _Service(
        onTap: () =>
            Get.to(const TakeAbsence(), arguments: {"classId": classId}),
        color: Colors.grey,
        icon: Icons.person_add_alt_1_outlined,
        service: "Take Absence",
      ),
      _Service(
        onTap: () =>
            Get.to(const StudentsDegree(), arguments: {"classId": classId}),
        color: Colors.indigoAccent,
        icon: Icons.stacked_bar_chart,
        service: "Students degrees",
      ),
      _Service(
        onTap: () =>
            Get.to(const AddAnotherEvent(), arguments: {"classId": classId}),
        color: Colors.blueAccent,
        icon: Icons.add,
        service: "Add other events",
      ),
      _Service(
        onTap: () => Get.to(const ChatPage(), arguments: {"classId": classId}),
        color: Colors.orange,
        icon: Icons.chat,
        service: "Chat Room",
      ),
      _Service(
        onTap: () => Get.to(const MakeQuiz(), arguments: {"classId": classId}),
        color: Colors.redAccent,
        icon: Icons.quiz,
        service: "Quiz",
      ),
      _Service(
        onTap: () =>
            Get.to(const DataForDoctor(), arguments: {"classId": classId}),
        color: Colors.tealAccent,
        icon: Icons.menu_book_sharp,
        service: "Data",
      ),
    ];
  }

  FutureOr<void> _deleteClassForDoctor(
      DeleteClassForDoctorEvent event, Emitter<ClassRoomState> emit) async {
    try {
      await deleteClass(classId);
      Get.offAll(const DoctorHomePage());
    } catch (e) {
      throw Exception();
    }
  }

  FutureOr<void> _checkAllowed(
      CheckAllowed event, Emitter<ClassRoomState> emit) async {
    bool? allowed = await getAllowedValue(
        classId, Shared().id.toString(), Shared().id.toString());
    isAllowed = allowed ?? false;
  }

  FutureOr<void> _leaveClassForStudent(
      LeaveClassForStudent event, Emitter<ClassRoomState> emit) async {
    try {
      await deleteParticipant(event.classId, Shared().userName, Shared().id);
      Get.offAll(const StudentHomePage());
    } catch (e) {
      throw Exception();
    }
  }

  FutureOr<void> _goToOneStudentDegree(
      GoToOneStudentDegree event, Emitter<ClassRoomState> emit) {
    Get.to(() => const OneStudentDegree(), arguments: {
      "classId": classId,
      "studentId": Shared().id,
      "studentName": Shared().userName
    });
  }

  FutureOr<void> _goToEnrollAbsence(
      GoToEnrollInAbsence event, Emitter<ClassRoomState> emit) async {
    await FlutterBarcodeScanner.scanBarcode(
            "#2A99CF", "cancel", true, ScanMode.QR)
        .then((value) {
      enrollInAbsence(classId, value.toString(), Shared().userName.toString(),
          Shared().id.toString());
    });
  }

  FutureOr<void> _goToData(GoToData event, Emitter<ClassRoomState> emit) async {
    Get.to(() => const DataForStudents(), arguments: {
      "classId": classId,
    });
  }

  FutureOr<void> _goToQuiz(GoToQuiz event, Emitter<ClassRoomState> emit) async{
       bool? allowed = await getAllowedValue(classId,
                        Shared().id.toString(), quizIdCont.text);

                  isAllowed = allowed ?? false;

                    if (isAllowed) {
                      Get.to(() => const QuizPage(), arguments: {
                        "classId": classId,
                        "quizId": quizIdCont.text,
                      });
                quizIdCont.text = "";
                    } else {
                    quizIdCont.text = "";
                      Get.back();
                      Get.snackbar("Failed", "You are not allowed");
                    }
  }

  FutureOr<void> _goToChatRoom(
      GoToChatRoom event, Emitter<ClassRoomState> emit) {
    Get.to(() => const ChatPage(), arguments: {
      "classId": classId,
    });
  }
}
