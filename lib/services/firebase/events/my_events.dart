// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

getMyEvents(classId) async {
  List events = [];
  await FirebaseFirestore.instance
      .collection("classes")
      .where("id", isEqualTo: classId)
      .get()
      .then((value) => value.docs.forEach((element) {
            var eventData = element.data()['events'];
            if (eventData is List) {
              events.addAll(eventData);
            } else {
              print("Unexpected data type: ${eventData.runtimeType}");
            }
          }));
  return events;
}
