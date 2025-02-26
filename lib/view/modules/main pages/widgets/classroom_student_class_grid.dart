// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/class_room/class_room_bloc.dart';
import '../../../../core/constants/colors.dart';
import 'class_room_part.dart';

class ClassGrid extends StatelessWidget {
  final ClassRoomBloc controller;
  const ClassGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95.w,
      height: 70.h,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                controller.add(GoToOneStudentDegree());
              },
              child: ClassRoomPart(
                  color: Colors.teal,
                  icon: Icon(
                    size: 30.sp,
                    Icons.stacked_bar_chart,
                    color: MyColors().mainColors,
                  ),
                  service: "My degrees"),
            );
          }
          if (index == 1) {
            return InkWell(
              onTap: () async {
                controller.add(GoToEnrollInAbsence());
              },
              child: ClassRoomPart(
                  color: Colors.orange,
                  icon: Icon(
                    Icons.person_add_alt_1_outlined,
                    size: 30.sp,
                    color: MyColors().mainColors,
                  ),
                  service: "Enroll in Absence"),
            );
          }
          if (index == 2) {
            return InkWell(
              onTap: () async {
                controller.add(GoToData());
              },
              child: ClassRoomPart(
                  color: Colors.blue,
                  icon: Icon(
                    size: 30.sp,
                    Icons.menu_book_sharp,
                    color: MyColors().mainColors,
                  ),
                  service: "Data"),
            );
          }
          if (index == 4) {
            return InkWell(
              onTap: () async {
                controller.add(GoToChatRoom());
              },
              child: ClassRoomPart(
                  color: Colors.redAccent,
                  icon: Icon(
                    size: 30.sp,
                    Icons.chat,
                    color: MyColors().mainColors,
                  ),
                  service: "Chat Room"),
            );
          }
          if (index == 3) {
            return InkWell(
              onTap: () {
                Get.defaultDialog(
                  title: "Quiz",
                  titleStyle: TextStyle(
                    color: MyColors().mainColors,
                    fontSize: 16.sp, // حجم خط متجاوب
                    fontWeight: FontWeight.bold,
                  ),
                  buttonColor: MyColors().mainColors,
                  cancelTextColor: MyColors().mainColors,
                  confirmTextColor: Colors.white,
                  radius: 12.sp, // زوايا ناعمة للحواف
                  content: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.w, vertical: 2.h), // تحسين التباعد
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // تجنب التمدد غير الضروري
                      children: [
                        TextFormField(
                          controller: controller.quizIdCont,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.abc,
                                size: 20.sp, color: MyColors().mainColors),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: MyColors().mainColors, width: 1.5),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            hintText: "Enter Quiz ID",
                            hintStyle:
                                TextStyle(fontSize: 12.sp, color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 1.5.h),
                          ),
                          style: TextStyle(fontSize: 14.sp),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                  onCancel: () {},
                  onConfirm: () async {
                    controller.add(GoToQuiz());
                  },
                );
              },
              child: ClassRoomPart(
                  color: Colors.green,
                  icon: Icon(
                    Icons.quiz,
                    size: 30.sp,
                    color: MyColors().mainColors,
                  ),
                  service: "Quiz"),
            );
          }

          return null;
        },
      ),
    );
  }
}
