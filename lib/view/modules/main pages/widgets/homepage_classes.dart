// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/class/class_bloc.dart';
import 'package:studify/view%20model/class/class_event.dart';
import 'package:studify/view/modules/main%20pages/widgets/doctor_homepage_widgets.dart';
import 'package:studify/view/modules/main%20pages/widgets/student_homepage_widgets.dart';
import '../../../../core/constants/colors.dart';

class ClassList extends StatelessWidget {
  final ClassBloc controller;
  final String type;

  const ClassList({super.key, required this.controller, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassBloc, ClassState>(
      builder: (context, state) {
        if (state is ClassLoading) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ClassLoaded) {
          if (state.classes.isEmpty) {
            return Expanded(
              child: Center(
                child: Text(
                  "There's no classes now",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: MyColors().mainColors,
                  ),
                ),
              ),
            );
          }
          return Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.classes.length,
              itemBuilder: (BuildContext context, int index) {
                return ClassListItem(
                  controller: controller,
                  classInfo: state.classes[index],
                  onClassTap: () {
                    type == "student"
                        ? controller.add(GoToStudentClass(
                            state.classes[index]['id'],
                            state.classes[index]['name'],
                            state.classes[index]['date']))
                        : controller.add(GoToDoctorClass(
                            state.classes[index]['id'],
                            state.classes[index]['name'],
                            state.classes[index]['date']));
                  },
                  type: type,
                );
              },
            ),
          );
        } else if (state is ClassError) {
          return Expanded(
            child: Center(
              child: Text(
                state.msg,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: MyColors().mainColors,
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class ClassListItem extends StatelessWidget {
  final ClassBloc controller;
  final Map<String, dynamic> classInfo;
  final VoidCallback onClassTap;
  final String type;
  

  const ClassListItem({
    super.key,
    required this.classInfo,
    required this.onClassTap,
    required this.type,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClassTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: MyColors().mainColors,
              offset: const Offset(0, 0),
              blurRadius: 5,
              blurStyle: BlurStyle.outer,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(10.sp),
        ),
        height: 12.h,
        margin: EdgeInsets.all(5.sp),
        child: ListTile(
          leading: Icon(
            Icons.class_,
            color: MyColors().mainColors,
          ),
          title: Text(
            classInfo['name'],
            style: TextStyle(
              fontSize: 15.sp,
              color: MyColors().mainColors,
            ),
          ),
          trailing: type == "student"
              ? SizedBox(
                  child: LeaveClassButton(
                      controller: controller, classId: classInfo['id']))
              : SizedBox(child: DeleteClassButton(classId: classInfo['id'])),
          subtitle: Text(
            "Date: ${classInfo['date']}",
            style: TextStyle(
              fontSize: 12.sp,
              color: MyColors().mainColors,
            ),
          ),
        ),
      ),
    );
  }
}
