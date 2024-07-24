import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/data/firebase/class/get%20_all_data.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data"),
        backgroundColor: MyColors().mainColors,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 10.sp),
          width: 100.w,
          height: 100.h,
          child: Column(
            children: [
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
                          child: Text('Error: ${snapshot.error}',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: MyColors().mainColors,
                              )));
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text(
                        'No data available',
                        style: TextStyle(
                            fontSize: 15.sp, color: MyColors().mainColors),
                      ));
                    }

                    final data = snapshot.data!;

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
                                      "$name",
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.white),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
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
