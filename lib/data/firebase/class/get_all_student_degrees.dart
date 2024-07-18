import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> getStudentScoresAndTotalInEvents(
    String classId, String studentId) async {
  List<Map<String, dynamic>> studentScoresInEvents = [];
  int totalScore = 0;
  int highTotalScore = 0;
  var querySnapshot = await FirebaseFirestore.instance
      .collection("classes")
      .where("id", isEqualTo: classId)
      .get();

  for (var doc in querySnapshot.docs) {
    var data = doc.data();

    if (data.containsKey('events') && data['events'] is List) {
      List events = data['events'];

      for (var event in events) {
        if (event.containsKey('studentsScores') &&
            event['studentsScores'] is List) {
          List studentsScores = event['studentsScores'];

          for (var studentScore in studentsScores) {
            if (studentScore['studentId'] == studentId) {
              int highScore = int.tryParse(event['totalScore']) ?? 0;
              int score = int.tryParse(studentScore['studentScore']) ?? 0;
              totalScore += score;
              highTotalScore += highScore;
              studentScoresInEvents.add({
                'eventName': event['eventName'],
                'totalScore': event['totalScore'],
                'studentName': studentScore['studentName'],
                'studentScore': score,
              });
            }
          }
        }
      }
    }
  }

  return {
    'highTotalScore': highTotalScore,
    'studentScoresInEvents': studentScoresInEvents,
    'totalScore': totalScore,
  };
}
