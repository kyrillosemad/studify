import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/constants/shared.dart';

addClassFun(name, date) async {
  int randomNumber = Random().nextInt(1000000);
  String id = randomNumber.toString();
  try {
    await FirebaseFirestore.instance.collection("classes").doc(id).set({
      "id": id,
      "date": date,
      "ownerId": Shared().id,
      "name": name,
      "participants": [],
      "data": [],
      "events": [],
      "chat": [],
    });
    Get.back();
    Get.snackbar("Done", "the class has been initialized",
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
