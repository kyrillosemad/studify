// ignore_for_file: unused_local_variable, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/core/services/services.dart';
import 'package:studify/view/modules/main%20pages/screens/doctor_home_page.dart';
import 'package:studify/view/modules/main%20pages/screens/student_home_page.dart';

Future<void> loginFun(String email, String password, String type) async {
  final services = Get.put(Services());
  try {
    bool isDoctor = false;
    bool founded = false;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .where('type', isEqualTo: type)
        .get();

    for (var doc in querySnapshot.docs) {
      services.userInfo!.setString("id", doc['id']);
      services.userInfo!.setString("username", doc['username']);
      services.userInfo!.setString("type", doc['type']);
      if (doc['type'] == "doctor") {
        isDoctor = true;
      } else {
        isDoctor = false;
      }
      founded = true;
    }

    if (founded) {
      if (isDoctor == true) {
        Get.offAll(const DoctorHomePage());
      } else {
        Get.offAll(const StudentHomePage());
      }

      Get.snackbar(
        "Success",
        "You have successfully logged in",
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
      Get.defaultDialog(
        title: "Wrong",
        titleStyle: TextStyle(color: MyColors().mainColors, fontSize: 20),
        content: Container(
          width: Get.width * 1,
          padding: const EdgeInsets.all(16),
          child: Text(
            "Email or Password isn't correct",
            textAlign: TextAlign.center,
            style: TextStyle(color: MyColors().mainColors, fontSize: 18),
          ),
        ),
        buttonColor: MyColors().mainColors,
        cancelTextColor: MyColors().mainColors,
        confirmTextColor: Colors.white,
        onCancel: () {},
      );
    }
  } catch (e) {
    throw Exception("error");
  }
}
