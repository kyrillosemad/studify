// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool?> getAllowedValue(
    String classId, String studentId, String eventId) async {
  bool? allowedValue;

  try {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("classes")
        .where("id", isEqualTo: classId)
        .get();

    for (var doc in querySnapshot.docs) {
      var data = doc.data();

      if (data.containsKey('events') && data['events'] is List) {
        List events = data['events'];

        for (var event in events) {
          if (event['eventId'] == eventId) {
            if (event.containsKey('studentsScores') &&
                event['studentsScores'] is List) {
              List studentsScores = event['studentsScores'];

              for (var studentScore in studentsScores) {
                if (studentScore['studentId'] == studentId) {
                  var allowedValueStr = studentScore['allowed']?.toString();
                  allowedValue = _parseToBool(allowedValueStr);
                  return allowedValue;
                }
              }
            }
          }
        }
      }
    }
  } catch (e) {}

  return allowedValue;
}

bool? _parseToBool(String? value) {
  if (value == null) return null;
  if (value.toLowerCase() == 'true') return true;
  if (value.toLowerCase() == 'false') return false;
  return null;
}
