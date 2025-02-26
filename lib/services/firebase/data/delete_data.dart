import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/core/constants/colors.dart';

deleteData(classId, dataId, dataUrl) async {
  try {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("classes")
        .where("id", isEqualTo: classId)
        .get();

    for (var doc in querySnapshot.docs) {
      var data = doc.data();

      if (data.containsKey('data') && data['data'] is List) {
        List myData = data['data'];

        var itemToDelete = myData.firstWhere((data) => data['id'] == dataId,
            orElse: () => null);

        if (itemToDelete != null) {
          if (itemToDelete.containsKey('url')) {
            var fileUrl = itemToDelete['url'];
            if (fileUrl == dataUrl) {
              var fileRef = FirebaseStorage.instance.refFromURL(fileUrl);
              await fileRef.delete();
            }
          }

          myData.removeWhere((data) => data['id'] == dataId);

          await FirebaseFirestore.instance
              .collection("classes")
              .doc(doc.id)
              .update({'data': myData});

          Get.back();
          Get.snackbar(
            "Done", // العنوان
            "Deleted successfully", // المحتوى
            backgroundColor: MyColors().mainColors.withOpacity(0.7),
            colorText: Colors.white,
            animationDuration: const Duration(milliseconds: 500),
            duration: const Duration(milliseconds: 2000),
            snackPosition: SnackPosition.BOTTOM,
            margin:
                EdgeInsets.symmetric(horizontal: Get.width * 0, vertical: 10),
            borderRadius: 12,
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
            snackStyle: SnackStyle.FLOATING,
          );
        } else {
          Get.back();
          Get.snackbar(
            "Error", // العنوان
            "Item not found", // المحتوى
            backgroundColor: MyColors().mainColors.withOpacity(0.7),
            colorText: Colors.white,
            animationDuration: const Duration(milliseconds: 500),
            duration: const Duration(milliseconds: 2000),
            snackPosition: SnackPosition.BOTTOM,
            margin:
                EdgeInsets.symmetric(horizontal: Get.width * 0, vertical: 10),
            borderRadius: 12,
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
            snackStyle: SnackStyle.FLOATING,
          );
        }
      } else {
        Get.back();
        Get.snackbar(
          "Error", // العنوان
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
  } catch (e) {
    Get.back();
    Get.snackbar(
      "Error",
      "An error occurred: $e",
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
