import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

deleteEvent(String classID, String eventId) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection("classes")
      .where("id", isEqualTo: classID)
      .get();

  for (var doc in querySnapshot.docs) {
    var data = doc.data();

    if (data.containsKey('events') && data['events'] is List) {
      List events = data['events'];

      events.removeWhere((event) => event['eventId'] == eventId);

      await FirebaseFirestore.instance
          .collection("classes")
          .doc(doc.id)
          .update({'events': events});
      Get.back();
      Get.snackbar("Done", "deleted successfully");
    } else {
      Get.back();
      Get.snackbar("Done", "there's something wrong");
    }
  }
}
