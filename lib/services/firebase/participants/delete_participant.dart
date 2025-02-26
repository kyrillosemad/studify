// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/core/constants/colors.dart';

deleteParticipant(classId, studentName, studentId) async {
  List<dynamic> participants = [];
  try {
    Get.back();
    await FirebaseFirestore.instance
        .collection("classes")
        .where("id", isEqualTo: classId)
        .get()
        .then((value) => value.docs.forEach((element) async {
              participants = element.data()['participants'];
              participants.removeWhere((participant) =>
                  participant['studentName'] == studentName &&
                  participant['studentId'] == studentId);

              await FirebaseFirestore.instance
                  .collection("classes")
                  .doc(classId)
                  .update({"participants": participants});
            }));

    Get.snackbar(
  "Success",
  "The participant has left",
  backgroundColor: MyColors().mainColors.withOpacity(0.7),
  colorText: Colors.white,
  animationDuration: const Duration(milliseconds: 500),
  duration: const Duration(milliseconds: 2000),
  snackPosition: SnackPosition.BOTTOM,
  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: 10),
  borderRadius: 12,
  isDismissible: true,
  forwardAnimationCurve: Curves.easeOutBack,
  snackStyle: SnackStyle.FLOATING,
);

  } catch (e) {
   Get.snackbar(
  "Failed",
  "There's something wrong",
  backgroundColor: MyColors().mainColors.withOpacity(0.7),
  colorText: Colors.white,
  animationDuration: const Duration(milliseconds: 500),
  duration: const Duration(milliseconds: 2000),
  snackPosition: SnackPosition.BOTTOM,
  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: 10),
  borderRadius: 12,
  isDismissible: true,
  forwardAnimationCurve: Curves.easeOutBack,
  snackStyle: SnackStyle.FLOATING,
);

  }
}
