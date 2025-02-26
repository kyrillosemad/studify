import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/services/firebase/participants/add_participants.dart';
import 'package:studify/view%20model/class/class_bloc.dart';
import 'package:studify/view%20model/class/class_event.dart';
import 'package:studify/view/modules/main%20pages/screens/student_home_page.dart';
import 'package:studify/view/modules/main%20pages/widgets/homepage_classes.dart';
import 'package:studify/view/modules/main%20pages/widgets/homepage_texts.dart';
import 'package:studify/view/shared_widgets/search_field.dart';
import '../../../../core/constants/shared.dart';

class StudentHomeBody extends StatelessWidget {
  final ClassBloc controller;

  const StudentHomeBody({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Center(
          child: SizedBox(
            width: 95.w,
            height: 90.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                const GreetingText(),
                SizedBox(height: 2.h),
                const InstructionsText(),
                SizedBox(height: 2.h),
                const ClassesTitle(),
                SizedBox(height: 2.h),
                SearchField(
                    hint: "Search",
                    onChanged: (value) {
                      controller.add(GetClassForStudent(value));
                    },
                    type: TextInputType.text),
                SizedBox(height: 2.h),
                ClassList(controller: controller, type: "student"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AddClassButton extends StatelessWidget {
  final ClassBloc controller;

  const AddClassButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      child: GestureDetector(
        child: CircleAvatar(
          backgroundColor: MyColors().mainColors,
          radius: 22.sp,
          child: IconButton(
            icon: Icon(
              Icons.add,
              size: 17.sp,
              color: Colors.white,
            ),
            onPressed: () {
              Get.defaultDialog(
                buttonColor: MyColors().mainColors,
                cancelTextColor: MyColors().mainColors,
                confirmTextColor: Colors.white,
                onCancel: () {},
                onConfirm: () async {
                  await addParticipant(
                    controller.classIdController.text,
                    Shared().id.toString(),
                    Shared().userName.toString(),
                  );
                  controller.classIdController.text = '';
                  Get.offAll(const StudentHomePage());
                },
                title: "Enroll in new class",
                titleStyle: TextStyle(color: MyColors().mainColors),
                content: SizedBox(
                  height: 6.h,
                  child: TextFormField(
                    controller: controller.classIdController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.abc),
                        focusedBorder: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(),
                        hintText: "Class ID",
                        hintStyle: TextStyle(fontSize: 15.sp)),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class LeaveClassButton extends StatelessWidget {
  final String classId;
  final ClassBloc controller;

  const LeaveClassButton({
    super.key,
    required this.controller,
    required this.classId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          buttonColor: MyColors().mainColors,
          cancelTextColor: MyColors().mainColors,
          confirmTextColor: Colors.white,
          title: "Leave?",
          titleStyle: TextStyle(
            color: MyColors().mainColors,
            fontSize: 16.sp, // حجم متجاوب للنص
            fontWeight: FontWeight.bold,
          ),
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w), // تباعد متجاوب
            child: Text(
              "Want to leave this class?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyColors().mainColors,
                fontSize: 14.sp, // حجم متجاوب
              ),
            ),
          ),
          radius: 12.sp, // جعل الحواف ناعمة ومتجاوبة
          onCancel: () {},
          onConfirm: () async {
            controller.add(LeaveClassForStudent(classId));
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.all(2.w), // تباعد متجاوب
        child: Icon(
          Icons.logout_outlined,
          size: 22.sp, // جعل الأيقونة متجاوبة
          color: MyColors().mainColors,
        ),
      ),
    );
  }
}
