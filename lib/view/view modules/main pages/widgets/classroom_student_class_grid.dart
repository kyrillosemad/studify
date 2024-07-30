// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/events/allowed.dart';
import 'package:studify/services/firebase/events/enroll_in_absence.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/constants/shared.dart';
import 'package:studify/view/view%20modules/class%20room/screens/chat_page.dart';
import 'package:studify/view/view%20modules/class%20room/screens/data_for_student.dart';
import 'package:studify/view/view%20modules/class%20room/screens/one_student_degree.dart';
import 'package:studify/view/view%20modules/class%20room/screens/quiz_page.dart';
import 'package:studify/view/view%20modules/main%20pages/widgets/class_room_part.dart';

class ClassGrid extends StatefulWidget {
  const ClassGrid({
    Key? key,
    required this.classId,
    required this.quizIdCont,
    required this.isAllowed,
    required this.onCheckAllowed,
  }) : super(key: key);

  final String classId;
  final TextEditingController quizIdCont;
  final bool isAllowed;
  final Future<void> Function() onCheckAllowed;

  @override
  _ClassGridState createState() => _ClassGridState();
}

class _ClassGridState extends State<ClassGrid> {
  late bool isAllowed;

  @override
  void initState() {
    super.initState();
    isAllowed = widget.isAllowed;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95.w,
      height: 70.h,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Get.to(() => const OneStudentDegree(), arguments: {
                  "classId": widget.classId,
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
                  enrollInAbsence(widget.classId, value.toString(),
                      Shared().userName.toString(), Shared().id.toString());
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
                Get.to(() => const DataForStudents(), arguments: {
                  "classId": widget.classId,
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
                Get.to(() => const ChatPage(), arguments: {
                  "classId": widget.classId,
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
                    bool? allowed = await getAllowedValue(widget.classId,
                        Shared().id.toString(), widget.quizIdCont.text);
                    setState(() {
                      isAllowed = allowed ?? false;
                    });

                    if (isAllowed) {
                      setState(() {
                        Get.to(() => const QuizPage(), arguments: {
                          "classId": widget.classId,
                          "quizId": widget.quizIdCont.text,
                        });
                      });
                      widget.quizIdCont.text = "";
                    } else {
                      widget.quizIdCont.text = "";
                      Get.back();
                      Get.snackbar("Failed", "You are not allowed");
                    }
                  },
                  title: "Quiz",
                  titleStyle: TextStyle(color: MyColors().mainColors),
                  content: SizedBox(
                      child: Column(
                    children: [
                      TextFormField(
                        controller: widget.quizIdCont,
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
    );
  }
}
