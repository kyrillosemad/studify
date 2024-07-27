import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> getAllParticipants(classId) async {
  List<Map<String, dynamic>> participants = [];
  await FirebaseFirestore.instance
      .collection("classes")
      .where("id", isEqualTo: classId)
      .get()
      .then((value) => value.docs.forEach((element) {
            List<dynamic> participantsList = element.data()['participants'];
            for (var participant in participantsList) {
              participants.add(participant as Map<String, dynamic>);
            }
          }));
  return participants;
}

