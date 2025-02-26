// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/data/data_bloc.dart';

class DataPageAppbar extends StatelessWidget implements PreferredSizeWidget {
  String classId;
  String type;
  DataPageAppbar({super.key, required this.type, required this.classId});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 7.h,
      title: type == "doctor"
          ? Text(
              "Insert Data",
              style: TextStyle(fontSize: 15.sp),
            )
          : Text("Data", style: TextStyle(fontSize: 15.sp)),
      backgroundColor: MyColors().mainColors,
      centerTitle: true,
      actions: [
        type == "doctor"
            ? InkWell(
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
              )
            : Container(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
