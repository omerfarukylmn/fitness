import 'package:fitness/screens/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:fitness/services/firestore_service.dart';
import 'package:fitness/utils/formatters.dart';

class ActivitySummaryScreen extends StatelessWidget {
  final String activityId;
  final Duration elapsedTime;

  ActivitySummaryScreen({required this.activityId, required this.elapsedTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aktivite Özeti'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: FirestoreService.fetchActivityData(activityId),
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
          final formattedTime = formatDuration(elapsedTime);

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
}