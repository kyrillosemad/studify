// ignore_for_file: unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/main.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/main%20pages/screens/doctor_home_page.dart';
import 'package:studify/view/view%20modules/main%20pages/screens/student_home_page.dart';

Future<void> loginFun(String email, String password, String type) async {
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
      userInfo!.setString("id", doc['id']);
      userInfo!.setString("username", doc['username']);
      userInfo!.setString("type", doc['type']);
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

      Get.snackbar("Success", "You have successfully logged in",
          backgroundColor: MyColors().mainColors.withOpacity(0.7),
          colorText: Colors.white,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 1500));
    } else {
      Get.defaultDialog(
        buttonColor: MyColors().mainColors,
        cancelTextColor: MyColors().mainColors,
        confirmTextColor: Colors.white,
        title: "Wrong",
        titleStyle: TextStyle(color: MyColors().mainColors),
        content: Text(
          "Email or Password isn't correct",
          style: TextStyle(color: MyColors().mainColors),
        ),
        onCancel: () {},
      );
    }
  } catch (e) {
    throw Exception("error");
  }
}
