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
        Get.snackbar("Success", "the student has been successfully added",
            backgroundColor: MyColors().mainColors.withOpacity(0.7),
            colorText: Colors.white,
            animationDuration: const Duration(milliseconds: 500),
            duration: const Duration(milliseconds: 1500));
      }).catchError((error) {
        Get.snackbar("Failed", "there's something wrong",
            backgroundColor: MyColors().mainColors.withOpacity(0.7),
            colorText: Colors.white,
            animationDuration: const Duration(milliseconds: 500),
            duration: const Duration(milliseconds: 1500));
      });
    } else {
      Get.snackbar("Failed", "there's something wrong",
          backgroundColor: MyColors().mainColors.withOpacity(0.7),
          colorText: Colors.white,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 1500));
    }
  }).catchError((error) {
    Get.snackbar("Failed", "there's something wrong",
        backgroundColor: MyColors().mainColors.withOpacity(0.7),
        colorText: Colors.white,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 1500));
  });
}
