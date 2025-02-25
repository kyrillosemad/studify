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
                  buttonColor: MyColors().mainColors,
                  cancelTextColor: MyColors().mainColors,
                  confirmTextColor: Colors.white,
                  onCancel: () {},
                  onConfirm: () async {
                    controller.add(GoToQuiz());
                  },
                  title: "Quiz",
                  titleStyle: TextStyle(color: MyColors().mainColors),
                  content: SizedBox(
                      child: Column(
                    children: [
                      TextFormField(
                        controller: controller.quizIdCont,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.abc),
                          focusedBorder: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          hintText: "Quiz Id",
                        ),
                      ),
                    ],
                  )),
                );
              },
              child: ClassRoomPart(
                  color: Colors.green,
                  icon: Icon(
                    Icons.quiz,
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
