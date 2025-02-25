import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/class/class_bloc.dart';
import 'package:studify/view%20model/class/class_event.dart';
import 'package:studify/view/modules/main%20pages/screens/doctor_home_page.dart';
import 'package:studify/view/modules/main%20pages/widgets/homepage_texts.dart';
import 'package:studify/view/shared_widgets/search_field.dart';

import 'homepage_classes.dart';

// Main Body Widget
class DoctorHomeBody extends StatelessWidget {
  final ClassBloc controller;
  const DoctorHomeBody({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
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
              SizedBox(
                  height: 7.h,
                  child: SearchField(
                      hint: "Search",
                      onChanged: (value) {
                        controller.add(GetClassForDoctor(value));
                      },
                      type: TextInputType.text)),
              SizedBox(height: 2.h),
              ClassList(controller: controller, type: "doctor")
            ],
          ),
        ),
      ),
    );
  }
}

// Delete Class Button Widget
class DeleteClassButton extends StatelessWidget {
  final String classId;
  const DeleteClassButton({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          buttonColor: MyColors().mainColors,
          cancelTextColor: MyColors().mainColors,
          confirmTextColor: Colors.white,
          title: "Delete class",
          titleStyle: TextStyle(color: MyColors().mainColors),
          content: Text(
            "Do you really want to delete this class?",
            style: TextStyle(color: MyColors().mainColors),
          ),
          onCancel: () {},
          onConfirm: () {
            context.read<ClassBloc>().add(DeleteClassForDoctor(classId));
            Get.offAll(const DoctorHomePage());
          },
        );
      },
      child: Icon(
        Icons.delete,
        color: MyColors().mainColors,
      ),
    );
  }
}

// Add Class Button Widget
class DoctorAddClassButton extends StatelessWidget {
  final ClassBloc controller;

  const DoctorAddClassButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: FloatingActionButton(
        backgroundColor: MyColors().mainColors,
        onPressed: () {
          Get.defaultDialog(
            buttonColor: MyColors().mainColors,
            cancelTextColor: MyColors().mainColors,
            confirmTextColor: Colors.white,
            title: "Add Class",
            titleStyle: TextStyle(color: MyColors().mainColors),
            content: Column(
              children: [
                TextFormField(
                  controller: controller.classNameCont,
                  style:
                      TextStyle(color: MyColors().mainColors, fontSize: 13.sp),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.class_,
                      color: MyColors().mainColors,
                    ),
                    hintText: "Class Name",
                    hintStyle: TextStyle(
                        color: MyColors().mainColors, fontSize: 13.sp),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  controller: controller.classDateCont,
                  style:
                      TextStyle(color: MyColors().mainColors, fontSize: 13.sp),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: MyColors().mainColors,
                    ),
                    hintText: "Class Date",
                    hintStyle: TextStyle(
                        color: MyColors().mainColors, fontSize: 13.sp),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                    ),
                  ),
                ),
              ],
            ),
            onCancel: () {},
            onConfirm: () {
              controller.add(AddClassForDoctor(controller.classNameCont.text,
                  controller.classNameCont.text));
              controller.classNameCont.clear();
              controller.classDateCont.clear();
              Get.offAll(const DoctorHomePage());
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
