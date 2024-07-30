part of 'degrees_bloc.dart';

sealed class DegreesState {}

final class DegreesInitial extends DegreesState {}

class DegreesLoading extends DegreesState {}

class DegreesLoaded extends DegreesState {
  List<Map<String, dynamic>> degrees;
  DegreesLoaded(this.degrees);
}

class DegreesError extends DegreesState {
  String msg;
  DegreesError(this.msg);
}