import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

enrollInAbsence(String classId, String eventId, String studentName,
    String studentId) async {
  try {
    var updatedEvents = [];

    await FirebaseFirestore.instance
        .collection("classes")
        .where("id", isEqualTo: classId)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        List<dynamic> eventsList = element.data()['events'];

        for (var event in eventsList) {
          if (event['eventId'] == eventId) {
            List<dynamic> studentsScores = event['studentsScores'];
            for (var student in studentsScores) {
              if (student['studentName'] == studentName &&
                  student['studentId'] == studentId) {
                student['studentScore'] = "1";
              }
            }
            updatedEvents.add(event);
          }
        }
      }
      await FirebaseFirestore.instance
          .collection("classes")
          .doc(classId)
          .update({
        "events": updatedEvents,
      });
    });
    Get.snackbar("Done", "You have successfully registered your attendance");
  } catch (e) {
    Get.snackbar("failed", "there's something wrong");
  }
}
