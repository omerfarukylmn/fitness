import 'package:fitness/screens/widgets/action_button.dart';
import 'package:fitness/screens/widgets/circular_stats.dart';
import 'package:flutter/material.dart';
import 'package:fitness/widgets/circular_stats.dart';
import 'package:fitness/widgets/action_button.dart';

class ProfileScreen extends StatelessWidget {
  final String userName;
  final double totalDistance;
  final Duration totalTime;
  final int activityCount;

  const ProfileScreen({
    required this.userName,
    required this.totalDistance,
    required this.totalTime,
    required this.activityCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/orman_web.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Text(
                  'Welcome, $userName!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                CircularStats(
                  totalDistance: totalDistance,
                  totalTime: totalTime,
                  activityCount: activityCount,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionButton(context: context, text: 'New Activity', route: '/activity'),
                    ActionButton(context: context, text: 'Activity History', route: '/activitySummary'),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}