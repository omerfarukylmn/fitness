import 'package:fitness/service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/services/firestore_service.dart';
import 'package:fitness/utils/formatters.dart';

class ActivityHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity History'),
        backgroundColor: Colors.teal[600],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreService.fetchActivityHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No activities found.'));
          }

          final activities = snapshot.data!.docs;

          return ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              final activityName = activity['activity'];
              final distance = activity['distance'];
              final elapsedTime = activity['elapsed_time'];
              final formattedTime = Duration(seconds: elapsedTime);

              return ListTile(
                title: Text(activityName),
                subtitle: Text(
                  'Distance: ${distance.toStringAsFixed(2)} km, Time: ${formatDuration(formattedTime)}',
                ),
                trailing: Icon(Icons.directions_run),
              );
            },
          );
        },
      ),
    );
  }
}