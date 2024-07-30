part of 'class_bloc.dart';

sealed class ClassState {}

final class ClassInitial extends ClassState {}

class ClassLoading extends ClassState {}

class ClassLoaded extends ClassState {
  List<Map<String, dynamic>> classes;
  ClassLoaded(this.classes);
}

class ClassError extends ClassState {
  String msg;
  ClassError(this.msg);
}
