import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/data/bloc/data_bloc.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/shared_widgets/search_field.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/data_page_appbar.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/data_part.dart';

class DataForStudents extends StatefulWidget {
  const DataForStudents({super.key});

  @override
  State<DataForStudents> createState() => _DataForStudentsState();
}

class _DataForStudentsState extends State<DataForStudents> {
  var classId = Get.arguments['classId'];

  @override
  void initState() {
    super.initState();
    context.read<DataBloc>().add(GetData(classId, ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DataPageAppbar(
          classId: classId,
          type: "student",
        ),
        body: Column(
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
              child: BlocListener<DataBloc, DataState>(
                listener: (context, state) {
                  if (state is DataError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.msg)),
                    );
                  } else if (state is DataSuccess) {
                    context.read<DataBloc>().add(GetData(classId, ""));
                  }
                },
                child: BlocBuilder<DataBloc, DataState>(
                  builder: (context, state) {
                    if (state is DataLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DataError) {
                      return Center(
                        child: Text(
                          'Error: ${state.msg}',
                          style: TextStyle(
                              fontSize: 15.sp, color: MyColors().mainColors),
                        ),
                      );
                    } else if (state is DataLoaded) {
                      final data = state.data;

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
                          classId: classId, data: data, type: "student");
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            )
          ],
        ));
  }
}
