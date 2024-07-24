import 'package:cloud_firestore/cloud_firestore.dart';

Stream<List<Map<String, dynamic>>> getAllMsgs(String classId) {
  return FirebaseFirestore.instance
      .collection("classes")
      .doc(classId)
      .snapshots()
      .map((snapshot) {
    if (snapshot.exists) {
      List<dynamic> chatList = snapshot.data()!['chat'];
      return List<Map<String, dynamic>>.from(chatList);
    } else {
      return [];
    }
  });
}
