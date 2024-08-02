import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/data/bloc/data_bloc.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/shared_widgets/search_field.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/data_page_appbar.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/data_part.dart';

class DataForDoctor extends StatefulWidget {
  const DataForDoctor({super.key});

  @override
  State<DataForDoctor> createState() => _DataForDoctorState();
}

class _DataForDoctorState extends State<DataForDoctor> {
  var classId = Get.arguments['classId'];
  TextEditingController searchController = TextEditingController();
  String searchText = "";

  @override
  void initState() {
    super.initState();
    context.read<DataBloc>().add(GetData(classId, searchText));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DataPageAppbar(type: "doctor", classId: classId),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 10.sp),
          width: 100.w,
          height: 100.h,
          child: Column(
            children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: SearchField(
                      hint: "Search",
                      onChanged: (value) {
                        setState(() {
                          context
                              .read<DataBloc>()
                              .add(GetData(classId, value.toString()));
                        });
                      },
                      type: TextInputType.text,
                    ),
                  ),
              Expanded(
                child: BlocBuilder<DataBloc, DataState>(
                  builder: (context, state) {
                    if (state is DataLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is DataError) {
                      return Center(
                        child: Text(
                          'Error: ${state.msg}',
                          style: TextStyle(
                              fontSize: 15.sp, color: MyColors().mainColors),
                        ),
                      );
                    }

                    if (state is DataLoaded) {
                      final data = state.data
                          .where((file) => file['name']
                              .toString()
                              .toLowerCase()
                              .contains(searchText))
                          .toList();

                      if (data.isEmpty) {
                        return Center(
                          child: Text(
                            'No data available',
                            style: TextStyle(
                                fontSize: 15.sp, color: MyColors().mainColors),
                          ),
                        );
                      }

                      return DataPart(
                        classId: classId,
                        data: state.data,
                        type: "doctor",
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
