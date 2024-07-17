import 'package:cloud_firestore/cloud_firestore.dart';

Stream<List<Map<String, dynamic>>> getAllParticipantsInEvent(
    String classId, String eventId) {
  return FirebaseFirestore.instance
      .collection("classes")
      .where("id", isEqualTo: classId)
      .snapshots()
      .map((snapshot) {
    List<Map<String, dynamic>> participants = [];
    for (var doc in snapshot.docs) {
      List<dynamic> eventsList = doc.data()['events'];
      for (var event in eventsList) {
        List<dynamic> participantsList = [];
        if (event['eventId'] == eventId) {
          participantsList = event['studentsScores'];
        }

        for (var participant in participantsList) {
          participants.add(participant as Map<String, dynamic>);
        }
      }
    }
    return participants;
  });
}
