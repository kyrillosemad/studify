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
            title: "Leave Class?",
            titleStyle: TextStyle(
              color: MyColors().mainColors,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            buttonColor: MyColors().mainColors,
            cancelTextColor: MyColors().mainColors,
            confirmTextColor: Colors.white,
            radius: 12.sp,
            content: Container(
              width: 20.w, // تحديد عرض مناسب لتجنب المشاكل
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.exit_to_app, color: Colors.red, size: 24.sp),
                    SizedBox(height: 2.h),
                    Text(
                      "Are you sure you want to leave this class?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: MyColors().mainColors,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
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
            color: Colors.red,
            borderRadius: BorderRadius.circular(10.sp),
          ),
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
