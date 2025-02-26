import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/core/constants/colors.dart';

deleteEvent(String classID, String eventId) async {
  Get.back();
  var querySnapshot = await FirebaseFirestore.instance
      .collection("classes")
      .where("id", isEqualTo: classID)
      .get();

  for (var doc in querySnapshot.docs) {
    var data = doc.data();

    if (data.containsKey('events') && data['events'] is List) {
      List events = data['events'];

      events.removeWhere((event) => event['eventId'] == eventId);

      await FirebaseFirestore.instance
          .collection("classes")
          .doc(doc.id)
          .update({'events': events});
      Get.snackbar(
        "Done",
        "Deleted successfully",
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
    } else {
      Get.snackbar(
        "Done",
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
    }
  }
}
