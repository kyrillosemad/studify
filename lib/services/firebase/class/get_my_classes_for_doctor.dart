// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studify/view/constants/shared.dart';

Future<List<Map<String, dynamic>>> getMyClassesForDoctor() async {
  List<Map<String, dynamic>> classList = [];

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("classes")
        .where("ownerId", isEqualTo: Shared().id)
        .get();

    for (var doc in querySnapshot.docs) {
      classList.add(doc.data() as Map<String, dynamic>);
    }
  } catch (e) {}

  return classList;
}
