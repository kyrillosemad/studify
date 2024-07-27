import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> getQuiz(
    String classId, String eventId) async {
  List<Map<String, dynamic>> quizQuestions = [];

  var querySnapshot = await FirebaseFirestore.instance
      .collection("classes")
      .where("id", isEqualTo: classId)
      .get();

  for (var doc in querySnapshot.docs) {
    var eventData = doc.data()['events'] as List<dynamic>;

    for (var event in eventData) {
      if (event['eventId'] == eventId) {
        var questions = event['questions'] as List<dynamic>?;
        if (questions != null) {
          for (var question in questions) {
            quizQuestions.add(question as Map<String, dynamic>);
          }
        }
      }
    }
  }

  return quizQuestions;
}
