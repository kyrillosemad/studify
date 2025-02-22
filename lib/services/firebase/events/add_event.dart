import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/services/firebase/participants/get_all_participants.dart';
addEvent(String classId, String eventName, String eventId, totalScore,
    questions) async {
  try {
    List events = [];
    Map newEvent = {};

    await FirebaseFirestore.instance
        .collection("classes")
        .where("id", isEqualTo: classId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          if (element.data().containsKey('events') &&
              element.data()['events'] != null) {
            events = List.from(element.data()['events']);
          }
        }
      }
    });

    List<Map<String, dynamic>> students = await getAllParticipants(classId);

    for (var element in students) {
      element['studentScore'] = "0";
      element['allowed'] = true;
    }

    newEvent = {
      "eventId": eventId,
      "eventName": eventName,
      "totalScore": totalScore,
      "eventDate": DateTime.now(),
      "studentsScores": students,
      "questions": questions,
    };
    events.add(newEvent);

    await FirebaseFirestore.instance.collection("classes").doc(classId).update({
      "events": events,
    });

    Get.snackbar("Done", "the event is added successfully",
        backgroundColor: MyColors().mainColors.withOpacity(0.7),
        colorText: Colors.white,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 1500));
  } catch (e) {
    Get.snackbar("Failed", "there's something wrong",
        backgroundColor: MyColors().mainColors.withOpacity(0.7),
        colorText: Colors.white,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 1500));
  }
}
