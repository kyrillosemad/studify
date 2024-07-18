import 'package:cloud_firestore/cloud_firestore.dart';

changeStudentScore(String classId, String studentId, String newScore,eventId) async {
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
          for (var studentScore in event['studentsScores']) {
            if (event['eventId']==eventId&&studentScore['studentId'] == studentId) {
              studentScore['studentScore'] = newScore;
            }
          }
        } else {
          print("No studentsScores field found in event: $event");
        }
      }

      await FirebaseFirestore.instance
          .collection("classes")
          .doc(doc.id)
          .update({'events': events});
    }
  }
}
