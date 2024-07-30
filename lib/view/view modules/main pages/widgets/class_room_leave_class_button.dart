
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/participants/bloc/participants_bloc.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/constants/shared.dart';
import 'package:studify/view/view%20modules/main%20pages/screens/student_home_page.dart';

class LeaveClassButton extends StatelessWidget {
  const LeaveClassButton({Key? key, required this.classId}) : super(key: key);

  final String classId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          Get.defaultDialog(
            buttonColor: MyColors().mainColors,
            cancelTextColor: MyColors().mainColors,
            confirmTextColor: Colors.white,
            title: "leave ?",
            titleStyle: TextStyle(color: MyColors().mainColors),
            content: Text(
              "want to leave this class?",
              style: TextStyle(color: MyColors().mainColors),
            ),
            onCancel: () {},
            onConfirm: () async {
              context.read<ParticipantsBloc>().add(DeleteParticipants(classId,
                  Shared().userName.toString(), Shared().id.toString()));
              Get.offAll(() => const StudentHomePage());
            },
          );
        },
        child: Container(
          width: 90.w,
          height: 6.h,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(10.sp)),
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
