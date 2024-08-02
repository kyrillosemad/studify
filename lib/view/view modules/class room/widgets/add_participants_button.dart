// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/participants/bloc/participants_bloc.dart';
import 'package:studify/view/constants/colors.dart';
class AddParticipantsButton extends StatelessWidget {
  String classId;
  TextEditingController studentIdCont;
  TextEditingController studentNameCont;
  GlobalKey<FormState> formKey;
  AddParticipantsButton(
      {super.key,
      required this.formKey,
      required this.classId,
      required this.studentIdCont,
      required this.studentNameCont});

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
              if (formKey.currentState!.validate()) {
                context.read<ParticipantsBloc>().add(
                      AddParticipants(
                        classId,
                        studentIdCont.text,
                        studentNameCont.text,
                      ),
                    );
                studentIdCont.clear();
                studentNameCont.clear();
              }
            },
            title: "New participant",
            titleStyle: TextStyle(color: MyColors().mainColors),
            content: Form(
              key: formKey,
              child: SizedBox(
                child: Column(
                  children: [
                    TextFormField(
                      controller: studentNameCont,
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
                      controller: studentIdCont,
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
