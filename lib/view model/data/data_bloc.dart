import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:studify/services/firebase/data/delete_data.dart';
import 'package:studify/services/firebase/data/get%20_all_data.dart';
import 'package:studify/services/firebase/data/upload_data.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial()) {
    on<AddData>(addDataFun);
    on<GetData>(getDataFun);
    on<DeleteData>(deleteDataFun);
  }
  var classId = Get.arguments['classId'];
  TextEditingController searchController = TextEditingController();
  String searchText = "";

  Future<void> addDataFun(AddData event, Emitter<DataState> emit) async {
    try {
      await uploadAndSaveFile(event.classId);

      add(GetData(event.classId, ''));
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }

  Future<void> getDataFun(GetData event, Emitter<DataState> emit) async {
    emit(DataLoading());
    try {
      Stream<List<Map<String, dynamic>>> dataStream =
          getDataStream(event.classId);
      await emit.forEach(
        dataStream,
        onData: (data) {
          if (event.searchQuery.isEmpty) {
            return DataLoaded(data);
          } else {
            var filteredData = data
                .where((element) => element['name']
                    .toString()
                    .toLowerCase()
                    .startsWith(event.searchQuery))
                .toList();

            return DataLoaded(filteredData);
          }
        },
        onError: (_, __) => DataError('Failed to fetch data'),
      );
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }

  Future<void> deleteDataFun(DeleteData event, Emitter<DataState> emit) async {
    try {
      await deleteData(event.classId, event.dataId, event.dataUrl);
      add(GetData(event.classId, ''));
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }
}
