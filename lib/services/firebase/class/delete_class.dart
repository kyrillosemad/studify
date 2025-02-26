import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/core/constants/colors.dart';

deleteClass(classId) async {
  try {
    await FirebaseFirestore.instance
        .collection("classes")
        .doc(classId)
        .delete();

    Get.back();
  Get.snackbar(
  "Done", // العنوان
  "The class has been deleted", // المحتوى
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

  } catch (e) {
    Get.back();
   Get.snackbar(
  "Failed", // العنوان
  "There's something wrong", // المحتوى
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

  }
}
