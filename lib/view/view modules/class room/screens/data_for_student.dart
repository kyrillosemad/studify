import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/data/bloc/data_bloc.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/class%20room/screens/pdf_viewer.dart';

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
      appBar: AppBar(
        title: const Text("Data"),
        backgroundColor: MyColors().mainColors,
        centerTitle: true,
      ),
      body: BlocListener<DataBloc, DataState>(
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
                  style:
                      TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
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

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final file = data[index];
                  final name = file['name'];
                  final url = file['url'];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfViewerPage(url: url),
                        ),
                      );
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp),
                          color: MyColors().mainColors.withOpacity(0.5),
                        ),
                        margin: EdgeInsets.all(5.sp),
                        width: 95.w,
                        height: 10.h,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                              child: Center(
                                child: Icon(
                                  Icons.picture_as_pdf,
                                  size: 27.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10.sp),
                                child: Text(
                                  name,
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.white),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
