import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studify/core/constants/colors.dart';

Future<void> uploadAndSaveFile(String classId) async {
  // Show a loading dialog
  Get.dialog(
    const Center(
      child: CircularProgressIndicator(),
    ),
    barrierDismissible: false,
  );

  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    PlatformFile file = result.files.first;

    if (file.path != null) {
      File localFile = File(file.path!);

      try {
        String fileName = file.name;
        Reference storageReference =
            FirebaseStorage.instance.ref().child('uploads/$classId/$fileName');
        UploadTask uploadTask = storageReference.putFile(localFile);

        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        DocumentReference classDocRef =
            FirebaseFirestore.instance.collection('classes').doc(classId);

        DocumentSnapshot classDoc = await classDocRef.get();
        Map<String, dynamic> data = classDoc.data() as Map<String, dynamic>;

        List<dynamic> fileUrls = data['data'] ?? [];

        fileUrls.add({
          "url": downloadUrl,
          "name": fileName,
          "date": DateTime.now(),
          "id": Random().nextInt(1000000000).toString(),
        });

        await classDocRef.update({'data': fileUrls});

        Get.back();

        Get.snackbar(
          "Done",
          "File uploaded successfully.",
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
      } catch (e) {
        Get.back();
        Get.snackbar(
          "Failed",
          "Error uploading file.",
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
    } else {
      Get.back();
    }
  } else {
    Get.back();
  }
}
