import 'package:cloud_firestore/cloud_firestore.dart';

Stream<List<Map<String, dynamic>>> getDataStream(String classId) {
  return FirebaseFirestore.instance
      .collection('classes')
      .doc(classId)
      .snapshots()
      .map((snapshot) {
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      List<dynamic> fileUrls = data['data'] ?? [];
      return fileUrls.cast<Map<String, dynamic>>();
    } else {
      return [];
    }
  });
}
