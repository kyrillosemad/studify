import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studify/view/view%20modules/auth/screens/login.dart';

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
    Get.snackbar("Done", "The account have been successfully created");
    Get.offAll(const Login());
  } catch (e) {
    Get.snackbar("obs!!!", "there's something wrong");
  }
}
