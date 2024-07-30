part of 'data_bloc.dart';

abstract class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final List<Map<String, dynamic>> data;
  DataLoaded(this.data);
}

class DataError extends DataState {
  final String msg;
  DataError(this.msg);
}

class DataSuccess extends DataState {}
  