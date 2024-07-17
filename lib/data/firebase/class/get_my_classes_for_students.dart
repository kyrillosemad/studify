import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studify/view/constants/shared.dart';

Future<List<Map<String, dynamic>>> getMyClassesForStudents() async {
  List<Map<String, dynamic>> classes = [];
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection("classes")
      .where("participants", arrayContains: {
    "studentName": Shared().userName,
    "studentId": Shared().id
  }).get();
  // Use snapshot to access documents
  for (var doc in snapshot.docs) {
    // Access document data using doc.data()
    classes.add(doc.data() as Map<String, dynamic>);
  }
  return classes;
}
