import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/data/firebase/class/delete_participant.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/constants/shared.dart';
import 'package:studify/view/view%20modules/class%20room/screens/enroll_in_absence.dart';
import 'package:studify/view/view%20modules/class%20room/screens/one_student_degree.dart';
import 'package:studify/view/view%20modules/main%20pages/screens/student_home_page.dart';
import 'package:studify/view/view%20modules/main%20pages/widgets/class_room_part.dart';

class StudentClassRoom extends StatefulWidget {
  const StudentClassRoom({super.key});

  @override
  State<StudentClassRoom> createState() => _StudentClassRoomState();
}

class _StudentClassRoomState extends State<StudentClassRoom> {
  var date = Get.arguments['date'];
  var className = Get.arguments['className'];
  var classId = Get.arguments['classId'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors().mainColors,
          title: Text("$className"),
          centerTitle: true,
        ),
        body: Center(
          child: SizedBox(
            width: 97.w,
            height: 95.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "date : $date",
                  style:
                      TextStyle(fontSize: 17.sp, color: MyColors().mainColors),
                ),
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  width: 95.w,
                  height: 70.h,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return InkWell(
                          onTap: () {
                            Get.to(const OneStudentDegree(), arguments: {
                              "classId": classId,
                              "studentId": Shared().id,
                              "studentName": Shared().userName
                            });
                          },
                          child: ClassRoomPart(
                              icon: Icon(
                                Icons.stacked_bar_chart,
                                color: MyColors().mainColors,
                              ),
                              service: "My degrees"),
                        );
                      }
                      if (index == 1) {
                        return InkWell(
                          onTap: () {
                            Get.to(const EnrollInAbsence(), arguments: {
                              "classId": classId,
                            });
                          },
                          child: ClassRoomPart(
                              icon: Icon(
                                Icons.person_add_alt_1_outlined,
                                color: MyColors().mainColors,
                              ),
                              service: "Enroll in Absence"),
                        );
                      }
                      if (index == 2) {
                        return ClassRoomPart(
                            icon: Icon(
                              Icons.menu_book_sharp,
                              color: MyColors().mainColors,
                            ),
                            service: "Data");
                      }
                      if (index == 3) {
                        return ClassRoomPart(
                            icon: Icon(
                              Icons.video_call,
                              color: MyColors().mainColors,
                            ),
                            service: "Video call");
                      }

                      if (index == 4) {
                        return ClassRoomPart(
                            icon: Icon(
                              Icons.quiz,
                              color: MyColors().mainColors,
                            ),
                            service: "Quiz");
                      }

                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Center(
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
                          await deleteParticipant(
                              classId, Shared().userName, Shared().id);
                          Get.offAll(const StudentHomePage());
                        },
                      );
                    },
                    child: Container(
                      width: 90.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10.sp)),
                      child: Center(
                        child: Text(
                          "Leave this class ",
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
