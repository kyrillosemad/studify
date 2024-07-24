import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studify/view/constants/shared.dart';

Future<void> sendMsg(String classId, String msg) async {
  List<Map<String, dynamic>> msgs = [];
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("classes")
        .doc(classId)
        .get();
    if (documentSnapshot.exists) {
      var data = documentSnapshot.data() as Map<String, dynamic>;
      List<dynamic> chatList = data['chat'];
      msgs = List<Map<String, dynamic>>.from(chatList);
    }

    Map<String, dynamic> newMsg = {
      "date": DateTime.now(),
      "msg": msg,
      "ownerId": Shared().id,
      "ownerName": Shared().userName,
    };

    msgs.add(newMsg);

    await FirebaseFirestore.instance.collection("classes").doc(classId).update({
      "chat": msgs,
    });
  } catch (e) {
    print("Error: $e");
  }
}
