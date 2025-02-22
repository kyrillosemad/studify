import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/core/constants/colors.dart';

import '../../../view/modules/auth/screens/login.dart';


signUpFun(username, email, password, type) {
  try {
    int randomNumber = Random().nextInt(1000000);
    String id = randomNumber.toString();
    FirebaseFirestore.instance.collection("users").add({
      "id": id,
      "username": username,
      "email": email,
      "password": password,
      "type": type,
    });
    Get.snackbar("Done", "The account have been successfully created",
        backgroundColor: MyColors().mainColors.withOpacity(0.7),
        colorText: Colors.white,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 1500));
    Get.offAll(const LoginPage());
  } catch (e) {
    Get.snackbar("obs!", "there's something wrong",
        backgroundColor: MyColors().mainColors.withOpacity(0.7),
        colorText: Colors.white,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 1500));
  }
}
