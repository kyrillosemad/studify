import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> getStudentScoresAndTotalInEvents(
    String classId, String studentId) async {
  List<Map<String, dynamic>> studentScoresInEvents = [];
  double totalScore = 0;
  double highTotalScore = 0;

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
              double highScore = _parseToDouble(event['totalScore']);
              double score = _parseToDouble(studentScore['studentScore']);
              totalScore += score;
              highTotalScore += highScore;
              studentScoresInEvents.add({
                'eventName': event['eventName'],
                'totalScore': highScore,
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

double _parseToDouble(dynamic value) {
  if (value is int) {
    return value.toDouble();
  } else if (value is double) {
    return value;
  } else if (value is String) {
    return double.tryParse(value) ?? 0.0;
  }
  return 0.0;
}
