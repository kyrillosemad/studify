part of 'data_bloc.dart';

abstract class DataEvent {}

class AddData extends DataEvent {
  final String classId;
  AddData(this.classId);
}

class GetData extends DataEvent {
  final String classId;
  final String searchQuery;
  GetData(this.classId, this.searchQuery);
}

class DeleteData extends DataEvent {
  final String classId;
  final String dataId;
  final String dataUrl;
  DeleteData(this.classId, this.dataId, this.dataUrl);
}
