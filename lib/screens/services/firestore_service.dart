import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static Stream<QuerySnapshot> fetchActivityHistory() {
    return FirebaseFirestore.instance
        .collection('activities')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  static Future<Map<String, dynamic>> fetchActivityData(String activityId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('activities')
          .doc(activityId)
          .get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        throw Exception('Activity not found');
      }
    } catch (e) {
      print('Error fetching activity data: $e');
      throw e;
    }
  }
}