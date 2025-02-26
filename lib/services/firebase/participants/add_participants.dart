import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/core/constants/colors.dart';

addParticipant(String classId, String studentId, String studentName) async {
  Get.back();
  await FirebaseFirestore.instance
      .collection("classes")
      .where("id", isEqualTo: classId)
      .get()
      .then((QuerySnapshot querySnapshot) async {
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = querySnapshot.docs.first;

      List<dynamic> participants = doc['participants'];

      Map<String, dynamic> newParticipant = {
        'studentId': studentId,
        'studentName': studentName,
      };

      participants.add(newParticipant);

      await FirebaseFirestore.instance
          .collection("classes")
          .doc(doc['id'])
          .update({
        'participants': participants,
      }).then((_) async {
      Get.snackbar(
  "Success",
  "The student has been successfully added",
  backgroundColor: MyColors().mainColors.withOpacity(0.7),
  colorText: Colors.white,
  animationDuration: const Duration(milliseconds: 500),
  duration: const Duration(milliseconds: 2000),
  snackPosition: SnackPosition.BOTTOM,
  margin: EdgeInsets.symmetric(horizontal: Get.width * 0, vertical: 10),
  borderRadius: 12,
  isDismissible: true,
  forwardAnimationCurve: Curves.easeOutBack,
  snackStyle: SnackStyle.FLOATING,
);

      }).catchError((error) {
        Get.snackbar(
  "Failed",
  "There's something wrong",
  backgroundColor: MyColors().mainColors.withOpacity(0.7),
  colorText: Colors.white,
  animationDuration: const Duration(milliseconds: 500),
  duration: const Duration(milliseconds: 2000),
  snackPosition: SnackPosition.BOTTOM,
  margin: EdgeInsets.symmetric(horizontal: Get.width * 0, vertical: 10),
  borderRadius: 12,
  isDismissible: true,
  forwardAnimationCurve: Curves.easeOutBack,
  snackStyle: SnackStyle.FLOATING,
);

      });
    } else {
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
  }).catchError((error) {
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

  });
}
