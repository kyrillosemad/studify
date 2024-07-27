import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studify/view/constants/colors.dart';

deleteClass(classId) async {
  try {
    await FirebaseFirestore.instance
        .collection("classes")
        .doc(classId)
        .delete();

    Get.back();
    Get.snackbar("Done", "the class has been deleted",
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
