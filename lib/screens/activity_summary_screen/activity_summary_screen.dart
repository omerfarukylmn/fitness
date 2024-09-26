import 'package:fitness/service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:fitness/utils/formatters.dart';

class ActivitySummaryScreen extends StatelessWidget {
  final String activityId;
  final Duration elapsedTime;

  const ActivitySummaryScreen({super.key, required this.activityId, required this.elapsedTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aktivite Özeti'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: FirestoreService.fetchActivityData(activityId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Veri mevcut değil'));
          }

          final data = snapshot.data!;
          final activity = data['activity'];
          final distance = data['distance'];
          final formattedTime = formatDuration(elapsedTime);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aktivite: $activity',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'Mesafe: ${distance.toStringAsFixed(2)} km',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  'Geçen Süre: $formattedTime',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}