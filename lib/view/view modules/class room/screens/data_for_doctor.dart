import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/data/firebase/class/delete_data.dart';
import 'package:studify/data/firebase/class/get%20_all_data.dart';
import 'package:studify/data/firebase/class/upload_data.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insert Data"),
        backgroundColor: MyColors().mainColors,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              uploadAndSaveFile(classId);
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
                    });
                  },
                ),
              ),
              Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: getDataStream(classId),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(
                            fontSize: 15.sp, color: MyColors().mainColors),
                      ));
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text(
                        'No data available',
                        style: TextStyle(
                            fontSize: 15.sp, color: MyColors().mainColors),
                      ));
                    }

                    final data = snapshot.data!
                        .where((file) => file['name']
                            .toString()
                            .toLowerCase()
                            .contains(searchText))
                        .toList();

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
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 65.w,
                                    child: Container(
                                      padding: EdgeInsets.all(10.sp),
                                      child: Text(
                                        "$name",
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
                                        cancelTextColor: MyColors().mainColors,
                                        confirmTextColor: Colors.white,
                                        title: "Delete",
                                        titleStyle: TextStyle(
                                            color: MyColors().mainColors),
                                        content: Text(
                                          "delete this Data?",
                                          style: TextStyle(
                                              color: MyColors().mainColors),
                                        ),
                                        onCancel: () {},
                                        onConfirm: () {
                                          deleteData(
                                              classId,
                                              snapshot.data![index]['id'],
                                              snapshot.data![index]['url']);
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 20.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
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
