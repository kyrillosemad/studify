import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/class/delete_class.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/class%20room/screens/add_another_event.dart';
import 'package:studify/view/view%20modules/class%20room/screens/chat_page.dart';
import 'package:studify/view/view%20modules/class%20room/screens/data_for_doctor.dart';
import 'package:studify/view/view%20modules/class%20room/screens/make_quiz.dart';
import 'package:studify/view/view%20modules/class%20room/screens/my_events.dart';
import 'package:studify/view/view%20modules/class%20room/screens/participants.dart';
import 'package:studify/view/view%20modules/class%20room/screens/students_degrees.dart';
import 'package:studify/view/view%20modules/class%20room/screens/take_absence.dart';
import 'package:studify/view/view%20modules/main%20pages/screens/doctor_home_page.dart';
import 'package:studify/view/view%20modules/main%20pages/widgets/class_room_part.dart';

class DoctorClassRoom extends StatelessWidget {
  const DoctorClassRoom({super.key});

  @override
  Widget build(BuildContext context) {
    var classId = Get.arguments['classId'];
    var className = Get.arguments['className'];
    var date = Get.arguments['date'];
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
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "ClassID : $classId",
                  style:
                      TextStyle(fontSize: 17.sp, color: MyColors().mainColors),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Date : $date",
                  style:
                      TextStyle(fontSize: 17.sp, color: MyColors().mainColors),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Center(
                  child: SizedBox(
                    width: 95.w,
                    height: 67.h,
                    child: Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: 8,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return InkWell(
                              onTap: () {
                                Get.to(const Participants(), arguments: {
                                  "classId": classId,
                                });
                              },
                              child: ClassRoomPart(
                                  color: Colors.green,
                                  icon: Icon(
                                    Icons.group,
                                    color: MyColors().mainColors,
                                  ),
                                  service: "Participants"),
                            );
                          }
                          if (index == 3) {
                            return InkWell(
                              onTap: () {
                                Get.to(const StudentsDegree(), arguments: {
                                  "classId": classId,
                                });
                              },
                              child: ClassRoomPart(
                                  color: Colors.indigoAccent,
                                  icon: Icon(
                                    Icons.stacked_bar_chart,
                                    color: MyColors().mainColors,
                                  ),
                                  service: "Students degrees"),
                            );
                          }
                          if (index == 2) {
                            return InkWell(
                              onTap: () {
                                Get.to(const TakeAbsence(), arguments: {
                                  "classId": classId,
                                });
                              },
                              child: ClassRoomPart(
                                  color: Colors.grey,
                                  icon: Icon(
                                    Icons.person_add_alt_1_outlined,
                                    color: MyColors().mainColors,
                                  ),
                                  service: "Take Absence"),
                            );
                          }
                          if (index == 7) {
                            return InkWell(
                              onTap: () {
                                Get.to(const DataForDoctor(), arguments: {
                                  "classId": classId,
                                });
                              },
                              child: ClassRoomPart(
                                  color: Colors.tealAccent,
                                  icon: Icon(
                                    Icons.menu_book_sharp,
                                    color: MyColors().mainColors,
                                  ),
                                  service: "Data"),
                            );
                          }

                          if (index == 5) {
                            return InkWell(
                              onTap: () async {
                                Get.to(const ChatPage(), arguments: {
                                  "classId": classId,
                                });
                              },
                              child: ClassRoomPart(
                                  color: Colors.orange,
                                  icon: Icon(
                                    Icons.chat,
                                    color: MyColors().mainColors,
                                  ),
                                  service: "Chat Room"),
                            );
                          }
                          if (index == 6) {
                            return InkWell(
                              onTap: () {
                                Get.to(const MakeQuiz(), arguments: {
                                  "classId": classId,
                                });
                              },
                              child: ClassRoomPart(
                                  color: Colors.redAccent,
                                  icon: Icon(
                                    Icons.quiz,
                                    color: MyColors().mainColors,
                                  ),
                                  service: "Quiz"),
                            );
                          }
                          if (index == 4) {
                            return InkWell(
                              onTap: () {
                                Get.to(const AddAnotherEvent(), arguments: {
                                  "classId": classId,
                                });
                              },
                              child: ClassRoomPart(
                                  color: Colors.blueAccent,
                                  icon: Icon(
                                    Icons.add,
                                    color: MyColors().mainColors,
                                  ),
                                  service: "Add others events"),
                            );
                          }
                          if (index == 1) {
                            return InkWell(
                              onTap: () {
                                Get.to(const MyEvents(),
                                    arguments: {"classId": classId});
                              },
                              child: ClassRoomPart(
                                  color: Colors.amber,
                                  icon: Icon(
                                    Icons.event,
                                    color: MyColors().mainColors,
                                  ),
                                  service: "My events"),
                            );
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.defaultDialog(
                        buttonColor: MyColors().mainColors,
                        cancelTextColor: MyColors().mainColors,
                        confirmTextColor: Colors.white,
                        title: "delete ?",
                        titleStyle: TextStyle(color: MyColors().mainColors),
                        content: Text(
                          " want to delete this class?",
                          style: TextStyle(color: MyColors().mainColors),
                        ),
                        onCancel: () {},
                        onConfirm: () {
                          deleteClass(classId);
                          Get.offAll(const DoctorHomePage());
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
                          "Delete this class ",
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
        ),
      ),
    );
  }
}
