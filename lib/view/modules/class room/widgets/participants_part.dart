// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/participants/participants_bloc.dart';

class ParticipantsPart extends StatelessWidget {
  var state;
  String type;
  final ParticipantsBloc controller;
  ParticipantsPart(
      {super.key,
      required this.controller,
      required this.state,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: state.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: type == "studentsDegrees"
              ? () {
                  controller.add(GoToOneStudentDegree(state[index]['studentId'],
                      controller.classId, state[index]['studentName']));
                }
              : () {},
          child: Container(
            height: 10.h,
            margin: EdgeInsets.all(5.sp),
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
            child: ListTile(
              title: Text(
                state[index]['studentName'].toString(),
              ),
              subtitle: Text(
                "ID: ${state[index]['studentId'].toString()}",
              ),
              leading: Icon(
                Icons.person,
                color: MyColors().mainColors,
              ),
              trailing: type == "participants"
                  ? InkWell(
                      onTap: () {
                        Get.defaultDialog(
                          buttonColor: MyColors().mainColors,
                          cancelTextColor: MyColors().mainColors,
                          confirmTextColor: Colors.white,
                          title: "Delete?",
                          titleStyle: TextStyle(color: MyColors().mainColors),
                          content: Text(
                            "delete this participants",
                            style: TextStyle(color: MyColors().mainColors),
                          ),
                          onCancel: () {},
                          onConfirm: () {
                            controller.add(DeleteParticipants(
                                controller.classId,
                                state[index]['studentName'],
                                state[index]['studentId']));
                          },
                        );
                      },
                      child: Icon(Icons.delete, size: 25.sp, color: Colors.red),
                    )
                  : Container(
                      padding: EdgeInsets.only(right: 5.sp),
                      width: 5.w,
                      height: 5.h,
                      child: Center(
                          child: Icon(
                        Icons.ads_click,
                        size: 22.sp,
                        color: MyColors().mainColors,
                      )),
                    ),
            ),
          ),
        );
      },
    );
  }
}
