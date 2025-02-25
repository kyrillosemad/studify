import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/class_room/class_room_bloc.dart';

class ClassRoomLeaveClassButton extends StatelessWidget {
  final ClassRoomBloc controller;
  const ClassRoomLeaveClassButton(
      {Key? key, required this.classId, required this.controller})
      : super(key: key);
  final String classId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          Get.defaultDialog(
            buttonColor: MyColors().mainColors,
            cancelTextColor: MyColors().mainColors,
            confirmTextColor: Colors.white,
            title: "leave ?",
            titleStyle: TextStyle(color: MyColors().mainColors),
            content: Text(
              "want to leave this class?",
              style: TextStyle(color: MyColors().mainColors),
            ),
            onCancel: () {},
            onConfirm: () async {
              controller.add(LeaveClassForStudent(classId));
            },
          );
        },
        child: Container(
          width: 90.w,
          height: 6.h,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(10.sp)),
          child: Center(
            child: Text(
              "Leave this class",
              style: TextStyle(fontSize: 13.sp, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
