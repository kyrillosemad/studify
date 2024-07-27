import 'package:cloud_firestore/cloud_firestore.dart';

Stream<List<Map<String, dynamic>>> getStudentsDegreesInEvent(
    String classId, String eventId) {
  return FirebaseFirestore.instance
      .collection("classes")
      .where("id", isEqualTo: classId)
      .snapshots()
      .map((snapshot) {
    List<Map<String, dynamic>> participantsDegrees = [];
    for (var doc in snapshot.docs) {
      List<dynamic> eventsList = doc.data()['events'];
      for (var event in eventsList) {
        List<dynamic> participantsList = [];
        if (event['eventId'] == eventId) {
          participantsList = event['studentsScores'];
        }

        for (var participant in participantsList) {
          participantsDegrees.add(participant as Map<String, dynamic>);
        }
      }
    }
    return participantsDegrees;
  });
}
