import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularStats extends StatelessWidget {
  final double totalDistance;
  final Duration totalTime;
  final int activityCount;

  const CircularStats({
    required this.totalDistance,
    required this.totalTime,
    required this.activityCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            _buildCircularIndicator(
              radius: 190.0,
              lineWidth: 37.0,
              percent: totalDistance / 100,
              progressColor: Colors.red,
              backgroundColor: const Color.fromARGB(111, 244, 67, 54),
              icon: Icons.directions_walk,
              iconSize: 50.0,
            ),
            _buildCircularIndicator(
              radius: 150.0,
              lineWidth: 38.0,
              percent: totalTime.inMinutes / 1440,
              progressColor: Colors.green,
              backgroundColor: const Color.fromARGB(111, 76, 175, 79),
              icon: Icons.access_time,
              iconSize: 40.0,
            ),
            _buildCircularIndicator(
              radius: 110.0,
              lineWidth: 37.0,
              percent: activityCount / 100,
              progressColor: Colors.blue,
              backgroundColor: const Color.fromARGB(111, 33, 149, 243),
              icon: Icons.event,
              iconSize: 30.0,
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatColumn('${totalDistance.toStringAsFixed(1)} km', 'Distance'),
            _buildStatColumn('${totalTime.inMinutes} min', 'Time'),
            _buildStatColumn('$activityCount', 'Activities'),
          ],
        ),
      ],
    );
  }

  Widget _buildCircularIndicator({
    required double radius,
    required double lineWidth,
    required double percent,
    required Color progressColor,
    required Color backgroundColor,
    required IconData icon,
    required double iconSize,
  }) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      animation: true,
      percent: percent,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      center: Icon(icon, color: Colors.white, size: iconSize),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}