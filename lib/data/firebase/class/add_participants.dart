import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studify/view/constants/colors.dart';

addParticipant(String classId, String studentId, String studentName) async {
  await FirebaseFirestore.instance
      .collection("classes")
      .where("id", isEqualTo: classId)
      .get()
      .then((QuerySnapshot querySnapshot) async {
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = querySnapshot.docs.first;

      List<dynamic> participants = doc['participants'];

      Map<String, dynamic> newParticipant = {
        'studentId': studentId,
        'studentName': studentName,
      };

      participants.add(newParticipant);

      await FirebaseFirestore.instance
          .collection("classes")
          .doc(doc['id'])
          .update({
        'participants': participants,
      }).then((_) {
        Get.back();
        Get.snackbar("Success", "the student has been successfully added",
            colorText: MyColors().mainColors,
            animationDuration: const Duration(milliseconds: 500),
            duration: const Duration(milliseconds: 1500));
      }).catchError((error) {
        Get.back();
        Get.snackbar("Failed", "there's something wrong",
            colorText: MyColors().mainColors,
            animationDuration: const Duration(milliseconds: 500),
            duration: const Duration(milliseconds: 1500));
      });
    } else {
      Get.back();
      Get.snackbar("Failed", "there's something wrong",
          colorText: MyColors().mainColors,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 1500));
    }
  }).catchError((error) {
    Get.back();
    Get.snackbar("Failed", "there's something wrong",
        colorText: MyColors().mainColors,
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(milliseconds: 1500));
  });
}
