import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ActivitySummaryScreen extends StatelessWidget {
  late String activityId; 
  late Duration elapsedTime; 

  ActivitySummaryScreen({required this.activityId, required this.elapsedTime});

  Future<Map<String, dynamic>> _fetchActivityData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('activities')
          .doc(activityId)
          .get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        throw Exception('Aktivite bulunamadı');
      }
    } catch (e) {
      print('Aktivite verileri alınırken hata oluştu: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aktivite Özeti'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchActivityData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Veri mevcut değil'));
          }

          final data = snapshot.data!;
          final activity = data['activity'];
          final distance = data['distance'];
          final formattedTime = _formatDuration(elapsedTime);

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aktivite: $activity',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Mesafe: ${distance.toStringAsFixed(2)} km',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 8),
                Text(
                  'Geçen Süre: $formattedTime',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String ikiBasamak(int n) => n.toString().padLeft(2, '0');
    String ikiBasamakDakika = ikiBasamak(duration.inMinutes.remainder(60));
    String ikiBasamakSaniye = ikiBasamak(duration.inSeconds.remainder(60));
    return "${ikiBasamak(duration.inHours)}:$ikiBasamakDakika:$ikiBasamakSaniye";
  }
}