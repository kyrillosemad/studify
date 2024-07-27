import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/events/allowed.dart';
import 'package:studify/services/firebase/events/enroll_in_absence.dart';
import 'package:studify/services/firebase/participants/delete_participant.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/constants/shared.dart';
import 'package:studify/view/view%20modules/class%20room/screens/chat_page.dart';
import 'package:studify/view/view%20modules/class%20room/screens/data_for_student.dart';
import 'package:studify/view/view%20modules/class%20room/screens/one_student_degree.dart';
import 'package:studify/view/view%20modules/class%20room/screens/quiz_page.dart';
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

  late bool isAllowed;
  Future<void> _checkAllowedValue() async {
    bool? allowed =
        await getAllowedValue(classId, Shared().id.toString(), "85699");
    setState(() {
      isAllowed = allowed ?? false;
    });
  }

  TextEditingController quizIdCont = TextEditingController();
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
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "date : $date",
                    style: TextStyle(
                        fontSize: 17.sp, color: MyColors().mainColors),
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
                                color: Colors.teal,
                                icon: Icon(
                                  Icons.stacked_bar_chart,
                                  color: MyColors().mainColors,
                                ),
                                service: "My degrees"),
                          );
                        }
                        if (index == 1) {
                          return InkWell(
                            onTap: () async {
                              await FlutterBarcodeScanner.scanBarcode(
                                      "#2A99CF", "cancel", true, ScanMode.QR)
                                  .then((value) {
                                enrollInAbsence(
                                    classId,
                                    value.toString(),
                                    Shared().userName.toString(),
                                    Shared().id.toString());
                              });
                            },
                            child: ClassRoomPart(
                                color: Colors.orange,
                                icon: Icon(
                                  Icons.person_add_alt_1_outlined,
                                  color: MyColors().mainColors,
                                ),
                                service: "Enroll in Absence"),
                          );
                        }
                        if (index == 2) {
                          return InkWell(
                            onTap: () async {
                              Get.to(const DataForStudents(), arguments: {
                                "classId": classId,
                              });
                            },
                            child: ClassRoomPart(
                                color: Colors.blue,
                                icon: Icon(
                                  Icons.menu_book_sharp,
                                  color: MyColors().mainColors,
                                ),
                                service: "Data"),
                          );
                        }
                        if (index == 4) {
                          return InkWell(
                            onTap: () async {
                              Get.to(const ChatPage(), arguments: {
                                "classId": classId,
                              });
                            },
                            child: ClassRoomPart(
                                color: Colors.redAccent,
                                icon: Icon(
                                  Icons.chat,
                                  color: MyColors().mainColors,
                                ),
                                service: "Chat Room"),
                          );
                        }
                        if (index == 3) {
                          return InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                buttonColor: MyColors().mainColors,
                                cancelTextColor: MyColors().mainColors,
                                confirmTextColor: Colors.white,
                                onCancel: () {},
                                onConfirm: () async {
                                  bool? allowed = await getAllowedValue(classId,
                                      Shared().id.toString(), quizIdCont.text);
                                  setState(() {
                                    isAllowed = allowed ?? false;
                                  });

                                  if (isAllowed) {
                                    setState(() {
                                      Get.to(const QuizPage(), arguments: {
                                        "classId": classId,
                                        "quizId": quizIdCont.text,
                                      });
                                    });
                                    quizIdCont.text = "";
                                  } else {
                                    quizIdCont.text = "";
                                    Get.back();
                                    Get.snackbar(
                                        "Failed", "You are not allowed");
                                  }
                                },
                                title: "Quiz",
                                titleStyle:
                                    TextStyle(color: MyColors().mainColors),
                                content: SizedBox(
                                    child: Column(
                                  children: [
                                    TextFormField(
                                      controller: quizIdCont,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.abc),
                                        focusedBorder: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(),
                                        hintText: "Quiz Id",
                                      ),
                                    ),
                                  ],
                                )),
                              );
                            },
                            child: ClassRoomPart(
                                color: Colors.green,
                                icon: Icon(
                                  Icons.quiz,
                                  color: MyColors().mainColors,
                                ),
                                service: "Quiz"),
                          );
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
                            "Leave this class",
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
        ));
  }
}
