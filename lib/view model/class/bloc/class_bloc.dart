import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:studify/services/firebase/class/add_class_fun.dart';
import 'package:studify/services/firebase/class/delete_class.dart';
import 'package:studify/services/firebase/class/get_my_classes_for_doctor.dart';
import 'package:studify/services/firebase/class/get_my_classes_for_students.dart';
import 'package:studify/view%20model/class/bloc/class_event.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc() : super(ClassInitial()) {
    on<AddClassForDoctor>(_addClassForDoctorFun);
    on<DeleteClassForDoctor>(_deleteClassForDoctorFun);
    on<GetClassForDoctor>(_getClassForDoctorFun);
    on<GetClassForStudent>(_getClassForStudentFun);
  }

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
            .where((element) =>
                element.toString().toLowerCase().startsWith(event.searchQuery))
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
            .where((element) =>
                element.toString().toLowerCase().startsWith(event.searchQuery))
            .toList();
        emit(ClassLoaded(classes));
      }
    } catch (e) {
      emit(ClassError(e.toString()));
    }
  }
}
