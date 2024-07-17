import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studify/data/firebase/class/get_all_participants.dart';

addEvent(String classId, String eventName,String eventId) async {
  List events = [];
  Map newEvent = {};

  await FirebaseFirestore.instance
      .collection("classes")
      .where("id", isEqualTo: classId)
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      for (var element in value.docs) {
        if (element.data().containsKey('events') &&
            element.data()['events'] != null) {
          events = List.from(element.data()['events']);
        }
      }
    }
  });

  List<Map<String, dynamic>> students = await getAllParticipants(classId);

  for (var element in students) {
    element['studentScore'] = "0";
  }


  newEvent = {
    "eventId":eventId,
    "eventName": eventName,
    "eventDate": DateTime.now(),
    "studentsScores": students,
  };
  events.add(newEvent);

  await FirebaseFirestore.instance.collection("classes").doc(classId).update({
    "events": events,
  });
}
