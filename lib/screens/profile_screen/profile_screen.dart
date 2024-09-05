import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
                _buildInnerCircularStats(),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionButton(context, 'New Activity', '/activity'),
                    _buildActionButton(
                        context, 'Activity History', '/activitySummary'),
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

  Widget _buildInnerCircularStats() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircularPercentIndicator(
              radius: 190.0,
              lineWidth: 37.0,
              animation: true,
              percent: totalDistance / 100,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.red,
              backgroundColor: const Color.fromARGB(111, 244, 67, 54),
              center: Icon(
                Icons.directions_walk,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            CircularPercentIndicator(
              radius: 150.0,
              lineWidth: 38.0,
              animation: true,
              percent: totalTime.inMinutes / 1440,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.green,
              backgroundColor: const Color.fromARGB(111, 76, 175, 79),
              center: Icon(
                Icons.access_time,
                color: Colors.white,
                size: 40.0,
              ),
            ),
            CircularPercentIndicator(
              radius: 110.0,
              lineWidth: 37.0,
              animation: true,
              percent: activityCount / 100,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.blue,
              backgroundColor: const Color.fromARGB(111, 33, 149, 243),
              center: Icon(
                Icons.event,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 20), // Iconların üstünde boşluk bırakır
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatColumn(
                '${totalDistance.toStringAsFixed(1)} km', 'Distance'),
            _buildStatColumn('${totalTime.inMinutes} min', 'Time'),
            _buildStatColumn('$activityCount', 'Activities'),
          ],
        ),
      ],
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

  Widget _buildActionButton(BuildContext context, String text, String route) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}

Widget _buildActionButton(BuildContext context, String text, String route) {
  return Expanded(
    child: ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    ),
  );
}