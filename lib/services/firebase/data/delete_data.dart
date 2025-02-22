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
          Get.snackbar("Done", "Deleted successfully", backgroundColor: MyColors().mainColors.withOpacity(0.7),
        colorText: Colors.white,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 1500));
        } else {
          Get.back();
          Get.snackbar("Error", "Item not found");
        }
      } else {
        Get.back();
        Get.snackbar("Error", "There's something wrong");
      }
    }
  } catch (e) {
    Get.back();
    Get.snackbar("Error", "An error occurred: $e");
  }
}
