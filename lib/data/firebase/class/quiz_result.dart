import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/route_manager.dart';
import 'package:studify/view/constants/shared.dart';

Future<void> quizResult(String classId, String eventId, userAnswers) async {
  List<String> correctAnswers = [];
  double totalScore = 0;
  int highScore = 0;

  try {
    var classSnapshot = await FirebaseFirestore.instance
        .collection("classes")
        .where("id", isEqualTo: classId)
        .get();

    for (var classDoc in classSnapshot.docs) {
      List<dynamic> events = classDoc.data()['events'];
      for (var event in events) {
        if (event['eventId'] == eventId) {
          List<dynamic> questions = event['questions'];
          highScore = int.parse(event['totalScore']);
          for (var question in questions) {
            String correctOp = question['correctOp'] ?? '';
            correctAnswers.add(correctOp);
          }
          break;
        }
      }
    }

    for (var answer in userAnswers) {
      String userAnswer = answer['answer'] ?? '';
      if (correctAnswers.contains(userAnswer)) {
        totalScore++;
      }
    }

    var questionValue = highScore / correctAnswers.length;
    totalScore = totalScore * questionValue;

    var querySnapshot = await FirebaseFirestore.instance
        .collection("classes")
        .where("id", isEqualTo: classId)
        .get();

    for (var doc in querySnapshot.docs) {
      List<dynamic> events = doc.data()['events'] as List;
      for (var event in events) {
        if (event['eventId'] == eventId) {
          List<dynamic> studentsScores = event['studentsScores'];
          for (var studentScore in studentsScores) {
            if (studentScore['studentId'] == Shared().id) {
              studentScore['studentScore'] = totalScore.toString();
              studentScore['allowed'] = false;
            }
          }
          break;
        }
      }

      await FirebaseFirestore.instance
          .collection("classes")
          .doc(doc.id)
          .update({'events': events});
      Get.back();
      Get.back();
      Get.back();
      Get.snackbar("Done", "The Quiz is submitted successfully");
    }
  } catch (e) {
    Get.snackbar("Failed", "There's something wrong");
  }
}
