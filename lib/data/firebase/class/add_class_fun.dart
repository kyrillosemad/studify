import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studify/view/constants/shared.dart';

addClassFun(name,date) {
  int randomNumber = Random().nextInt(1000000);
  String id = randomNumber.toString();
  try {
    FirebaseFirestore.instance.collection("classes").doc(id).set({
      "id": id,
      "date" :date,
      "ownerId": Shared().id,
      "name": name,
      "participants": [],
      "data": [],
      "events": [],
    });
    Get.back();
    Get.snackbar("Done", "the class has been initialized");
  } catch (e) {
    Get.snackbar("Failed", "there's something wrong");
  }
}
