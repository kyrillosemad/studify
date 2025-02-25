// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/participants/participants_bloc.dart';

class AddParticipantsButton extends StatelessWidget {
  final ParticipantsBloc controller;
  const AddParticipantsButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Get.defaultDialog(
            buttonColor: MyColors().mainColors,
            cancelTextColor: MyColors().mainColors,
            confirmTextColor: Colors.white,
            onCancel: () {},
            onConfirm: () {
              if (controller.formKey.currentState!.validate()) {
                controller.add(AddParticipants(
                    controller.classId,
                    controller.studentIdCont.text,
                    controller.studentNameCont.text));
                controller.studentIdCont.clear();
                controller.studentNameCont.clear();
              }
            },
            title: "New participant",
            titleStyle: TextStyle(color: MyColors().mainColors),
            content: Form(
              key: controller.formKey,
              child: SizedBox(
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.studentNameCont,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.abc),
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        hintText: "Student Name",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the student name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      controller: controller.studentIdCont,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.perm_identity),
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        hintText: "Student ID",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the student ID';
                        }
                        final int? id = int.tryParse(value);
                        if (id == null || id <= 0) {
                          return 'Student ID must be a positive number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: Colors.green,
          ),
          width: 85.w,
          height: 7.h,
          child: Center(
            child: Text(
              "Add new participant",
              style: TextStyle(fontSize: 13.sp, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
