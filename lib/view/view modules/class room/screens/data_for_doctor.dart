import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/data/bloc/data_bloc.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/class%20room/screens/pdf_viewer.dart';

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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataBloc()..add(GetData(classId, searchText)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Insert Data"),
          backgroundColor: MyColors().mainColors,
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                context.read<DataBloc>().add(AddData(classId));
              },
              child: Container(
                padding: EdgeInsets.only(right: 5.sp),
                child: Icon(
                  Icons.file_upload_outlined,
                  size: 25.sp,
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.only(top: 10.sp),
            width: 100.w,
            height: 100.h,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.search, color: MyColors().mainColors),
                      hintText: "Search",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColors().mainColors),
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: MyColors().mainColors.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value.toLowerCase();
                        context
                            .read<DataBloc>()
                            .add(GetData(classId, searchText));
                      });
                    },
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
                                  fontSize: 15.sp,
                                  color: MyColors().mainColors),
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
                                    builder: (context) =>
                                        PdfViewerPage(url: url),
                                  ),
                                );
                              },
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.sp),
                                    color:
                                        MyColors().mainColors.withOpacity(0.5),
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
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 65.w,
                                        child: Container(
                                          padding: EdgeInsets.all(10.sp),
                                          child: Text(
                                            name,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.white,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.defaultDialog(
                                            buttonColor: MyColors().mainColors,
                                            cancelTextColor:
                                                MyColors().mainColors,
                                            confirmTextColor: Colors.white,
                                            title: "Delete",
                                            titleStyle: TextStyle(
                                                color: MyColors().mainColors),
                                            content: Text(
                                              "Delete this Data?",
                                              style: TextStyle(
                                                  color: MyColors().mainColors),
                                            ),
                                            onCancel: () {},
                                            onConfirm: () {
                                              context.read<DataBloc>().add(
                                                    DeleteData(
                                                      classId,
                                                      file['id'],
                                                      file['url'],
                                                    ),
                                                  );
                                            },
                                          );
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
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
      ),
    );
  }
}
