import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/core/constants/routes_name.dart';
import 'package:studify/core/constants/shared.dart';
import 'package:studify/services/firebase/class/add_class_fun.dart';
import 'package:studify/services/firebase/class/delete_class.dart';
import 'package:studify/services/firebase/class/get_my_classes_for_doctor.dart';
import 'package:studify/services/firebase/class/get_my_classes_for_students.dart';
import 'package:studify/services/firebase/participants/delete_participant.dart';
import 'package:studify/view%20model/class/class_event.dart';
import 'package:studify/view/modules/main%20pages/screens/student_home_page.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc() : super(ClassInitial()) {
    on<AddClassForDoctor>(_addClassForDoctorFun);
    on<DeleteClassForDoctor>(_deleteClassForDoctorFun);
    on<LeaveClassForStudent>(_leaveClassForStudent);
    on<GetClassForDoctor>(_getClassForDoctorFun);
    on<GetClassForStudent>(_getClassForStudentFun);
    on<GoToDoctorClass>(_goToDoctorClass);
    on<GoToStudentClass>(_goToStudentClass);
  }

  TextEditingController classId = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController classNameCont = TextEditingController();
  TextEditingController classDateCont = TextEditingController();
  TextEditingController classIdController = TextEditingController();
  FutureOr<void> _addClassForDoctorFun(
      AddClassForDoctor event, Emitter<ClassState> emit) async {
    try {
      await addClassFun(event.name, event.date);
      add(GetClassForDoctor(""));
    } catch (e) {
      emit(ClassError(e.toString()));
    }
  }

  FutureOr<void> _deleteClassForDoctorFun(
      DeleteClassForDoctor event, Emitter<ClassState> emit) async {
    try {
      await deleteClass(event.classId);
      add(GetClassForDoctor(""));
    } catch (e) {
      emit(ClassError(e.toString()));
    }
  }

  FutureOr<void> _getClassForDoctorFun(
      GetClassForDoctor event, Emitter<ClassState> emit) async {
    emit(ClassLoading());
    try {
      List<Map<String, dynamic>> classes = await getMyClassesForDoctor();
      if (event.searchQuery.isEmpty) {
        emit(ClassLoaded(classes));
      } else {
        classes = classes
            .where((element) => element['name']
                .toString()
                .toLowerCase()
                .startsWith(event.searchQuery))
            .toList();
        emit(ClassLoaded(classes));
      }
    } catch (e) {
      emit(ClassError(e.toString()));
    }
  }

  FutureOr<void> _getClassForStudentFun(
      GetClassForStudent event, Emitter<ClassState> emit) async {
    emit(ClassLoading());
    try {
      List<Map<String, dynamic>> classes = await getMyClassesForStudents();
      if (event.searchQuery.isEmpty) {
        emit(ClassLoaded(classes));
      } else {
        classes = classes
            .where((element) => element['name']
                .toString()
                .toLowerCase()
                .startsWith(event.searchQuery))
            .toList();
        emit(ClassLoaded(classes));
      }
    } catch (e) {
      emit(ClassError(e.toString()));
    }
  }

  FutureOr<void> _goToDoctorClass(
      GoToDoctorClass event, Emitter<ClassState> emit) {
    Get.toNamed(AppRoutes().doctorClassRoom, arguments: {
      "date": event.date.toString(),
      "classId": event.classId.toString(),
      "className": event.className.toString(),
    });
  }

  FutureOr<void> _goToStudentClass(
      GoToStudentClass event, Emitter<ClassState> emit) {
    Get.toNamed(AppRoutes().studentClassRoom, arguments: {
      "date": event.date.toString(),
      "classId": event.classId.toString(),
      "className": event.className.toString(),
    });
  }

  FutureOr<void> _leaveClassForStudent(
      LeaveClassForStudent event, Emitter<ClassState> emit) async {
    try {
      await deleteParticipant(event.classId, Shared().userName.toString(), Shared().id.toString());
      Get.offAll(const StudentHomePage());
    } catch (e) {
      throw Exception();
    }
  }
}
