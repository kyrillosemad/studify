import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/data/firebase/class/get_all_student_degrees.dart';
import 'package:studify/view/constants/colors.dart';

class OneStudentDegree extends StatefulWidget {
  const OneStudentDegree({super.key});

  @override
  State<OneStudentDegree> createState() => _OneStudentDegreeState();
}

class _OneStudentDegreeState extends State<OneStudentDegree> {
  var studentName = Get.arguments['studentName'];
  var studentId = Get.arguments['studentId'];
  var classId = Get.arguments['classId'];
  double totalScore = 0.0;
  double highTotalScore = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            getStudentScoresAndTotalInEvents(classId, studentId);
          },
          child: Text("$studentName"),
        ),
        centerTitle: true,
        backgroundColor: MyColors().mainColors,
      ),
      body: Center(
        child: SizedBox(
          width: 95.w,
          height: 100.h,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "There's all degrees of events of student $studentName",
                  style:
                      TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Expanded(
                  child: FutureBuilder(
                    future:
                        getStudentScoresAndTotalInEvents(classId, studentId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: MyColors().mainColors,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Error: ${snapshot.error}",
                            style: TextStyle(
                                fontSize: 15.sp, color: MyColors().mainColors),
                          ),
                        );
                      } else if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!['studentScoresInEvents'].isEmpty) {
                        return Center(
                          child: Text(
                            "No events found",
                            style: TextStyle(
                                fontSize: 15.sp, color: MyColors().mainColors),
                          ),
                        );
                      } else {
                        List<Map<String, dynamic>> studentScoresInEvents =
                            snapshot.data!['studentScoresInEvents'];
                        totalScore = snapshot.data!['totalScore'];
                        highTotalScore = snapshot.data!['highTotalScore'];
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: studentScoresInEvents.length,
                                itemBuilder: (context, index) {
                                  var classData = studentScoresInEvents[index];
                                  return Container(
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
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                    ),
                                    margin: EdgeInsets.all(8.sp),
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.class_,
                                        color: MyColors().mainColors,
                                      ),
                                      title: Text(
                                        classData['eventName'],
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: MyColors().mainColors),
                                      ),
                                      trailing: Text(
                                        "Score: ${classData['studentScore'].toStringAsFixed(1)} / ${classData['totalScore'].toStringAsFixed(1)}",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: MyColors().mainColors),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "Total Score: ${totalScore.toStringAsFixed(1)} / ${highTotalScore.toStringAsFixed(1)}",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: MyColors().mainColors),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
