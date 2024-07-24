// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:studify/view/constants/colors.dart';

deleteParticipant(classId, studentName, studentId) async {
  print("ttt");
  List<dynamic> participants = [];
  try {
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
    await FirebaseMessaging.instance.unsubscribeFromTopic('$classId');
    Get.back();
    Get.snackbar("Success", "the participant is leaved",
        colorText: MyColors().mainColors,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 1500));
  } catch (e) {
    Get.back();
    Get.snackbar("Failed", "there's something wrong",
        colorText: MyColors().mainColors,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 1500));
  }
}
