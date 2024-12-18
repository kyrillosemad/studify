// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/main%20pages/screens/doctor_class_room.dart';
import 'package:studify/view/view%20modules/main%20pages/screens/student_class_room.dart';
import 'package:studify/view/view%20modules/main%20pages/widgets/doctor_homepage_widgets.dart';
import 'package:studify/view/view%20modules/main%20pages/widgets/student_homepage_widgets.dart';
import '../../../../view model/class/bloc/class_bloc.dart';

class ClassList extends StatelessWidget {
  final ClassBloc classBloc;
  String Type;
  ClassList({super.key, required this.classBloc, required this.Type});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassBloc, ClassState>(
      bloc: classBloc,
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
                  "there's no classes now",
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
                  classInfo: state.classes[index],
                  onClassTap: Type == "student"
                      ? () {
                          Get.to(
                            const StudentClassRoom(),
                            arguments: {
                              "date": state.classes[index]['date'],
                              "classId": state.classes[index]['id'],
                              "className": state.classes[index]['name'],
                            },
                          );
                        }
                      : () {
                          Get.to(
                            const DoctorClassRoom(),
                            arguments: {
                              "date": state.classes[index]['date'],
                              "classId": state.classes[index]['id'],
                              "className": state.classes[index]['name'],
                            },
                          );
                        },
                  type: Type,
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
  final Map<String, dynamic> classInfo;
  final VoidCallback onClassTap;
  String type;
  ClassListItem({
    super.key,
    required this.classInfo,
    required this.onClassTap,
    required this.type,
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
            "${classInfo['name']}",
            style: TextStyle(
              fontSize: 15.sp,
              color: MyColors().mainColors,
            ),
          ),
          trailing: type == "student"
              ? LeaveClassButton(classId: classInfo['id'])
              : DeleteClassButton(classId: classInfo['id']),
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
