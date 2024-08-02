// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/data/bloc/data_bloc.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/class%20room/screens/pdf_viewer.dart';

class DataPart extends StatelessWidget {
  var data;
  String classId;
  String type;
  DataPart(
      {super.key,
      required this.classId,
      required this.data,
      required this.type});

  @override
  Widget build(BuildContext context) {
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
                  type == "doctor"
                      ? InkWell(
                          onTap: () {
                            Get.defaultDialog(
                              buttonColor: MyColors().mainColors,
                              cancelTextColor: MyColors().mainColors,
                              confirmTextColor: Colors.white,
                              title: "Delete",
                              titleStyle:
                                  TextStyle(color: MyColors().mainColors),
                              content: Text(
                                "Delete this Data?",
                                style: TextStyle(color: MyColors().mainColors),
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
                        )
                      : Container(
                          color: Colors.red,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
