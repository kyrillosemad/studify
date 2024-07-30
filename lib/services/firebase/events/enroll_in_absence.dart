import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/view/constants/colors.dart';

enrollInAbsence(String classId, String eventId, String studentName,
    String studentId) async {
  try {
    var updatedEvents = [];

    await FirebaseFirestore.instance
        .collection("classes")
        .doc(classId)
        .get()
        .then((doc) async {
      if (doc.exists) {
        List<dynamic> eventsList = doc.data()!['events'];
        bool foundEvent = false;

        for (var event in eventsList) {
          if (event['eventId'] == eventId) {
            foundEvent = true;
            List<dynamic> studentsScores = event['studentsScores'];
            for (var student in studentsScores) {
              if (student['studentName'] == studentName &&
                  student['studentId'] == studentId) {
                student['studentScore'] = event['totalScore'];
              }
            }
            updatedEvents.add(event);
          } else {
            updatedEvents.add(event);
          }
        }

        if (foundEvent) {
          await FirebaseFirestore.instance
              .collection("classes")
              .doc(classId)
              .update({
            "events": updatedEvents,
          });
          Get.snackbar(
              "Done", "You have successfully registered your attendance",
              backgroundColor: MyColors().mainColors.withOpacity(0.7),
              colorText: Colors.white,
              animationDuration: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 1500));
        } else {
          Get.snackbar("Error", "Event ID is incorrect",
              backgroundColor: MyColors().mainColors.withOpacity(0.7),
              colorText: Colors.white,
              animationDuration: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 1500));
        }
      } else {
        Get.snackbar("Error", "Class not found",
            backgroundColor: MyColors().mainColors.withOpacity(0.7),
            colorText: Colors.white,
            animationDuration: const Duration(milliseconds: 500),
            duration: const Duration(milliseconds: 1500));
      }
    });
  } catch (e) {
    Get.snackbar("Failed", "There's something wrong",
        backgroundColor: MyColors().mainColors.withOpacity(0.7),
        colorText: Colors.white,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 1500));
  }
}
