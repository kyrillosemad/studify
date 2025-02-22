// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/services/firebase/events/allowed.dart';
import 'package:studify/view/modules/main%20pages/widgets/class_room_class_date.dart';
import 'package:studify/view/modules/main%20pages/widgets/class_room_leave_class_button.dart';

import '../../../../core/constants/shared.dart';
import '../widgets/classroom_student_class_grid.dart';


class StudentClassRoom extends StatefulWidget {
  const StudentClassRoom({super.key});

  @override
  State<StudentClassRoom> createState() => _StudentClassRoomState();
}

class _StudentClassRoomState extends State<StudentClassRoom> {
  var date = Get.arguments['date'];
  var className = Get.arguments['className'];
  var classId = Get.arguments['classId'];

  late bool isAllowed;
  TextEditingController quizIdCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    isAllowed = false;
    _checkAllowedValue();
  }

  Future<void> _checkAllowedValue() async {
    bool? allowed =
        await getAllowedValue(classId, Shared().id.toString(), "85699");
    setState(() {
      isAllowed = allowed ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors().mainColors,
        title: Text("$className"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Center(
          child: SizedBox(
            width: 97.w,
            height: 95.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                ClassDate(date: date),
                SizedBox(height: 4.h),
                ClassGrid(
                  classId: classId,
                  quizIdCont: quizIdCont,
                  isAllowed: isAllowed,
                  onCheckAllowed: _checkAllowedValue,
                ),
                SizedBox(height: 1.h),
                LeaveClassButton(classId: classId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
