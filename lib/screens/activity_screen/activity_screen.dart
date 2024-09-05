import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fitness/screens/activity_in/activity_in_progress_screen.dart';


class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String selectedActivity = '';
  int countdown = 3;
  Timer? _timer;

  void _startActivity() {
    if (selectedActivity.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an activity')),
      );
      return;
    }

    setState(() {
      countdown = 3;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown == 0) {
        timer.cancel();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityInProgressScreen(
              activity: selectedActivity,
            ),
          ),
        );
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/orman.webp',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select an activity:',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: [
                    _buildActivityButton('Running', Icons.directions_run),
                    _buildActivityButton('Cycling', Icons.directions_bike),
                    _buildActivityButton('Swimming', Icons.pool),
                    _buildActivityButton('Walking', Icons.directions_walk),
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _startActivity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Start Activity',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (countdown < 3)
                  Container(
                    color: Colors.black, // Tam ekran için siyah arka plan
                    child: Center(
                      child: Text(
                        '$countdown',
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.red, // Geri sayım rengi
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityButton(String activity, IconData icon) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedActivity = activity;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selectedActivity == activity ? Colors.green : Colors.grey[700],
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
            color: selectedActivity == activity
                ? Colors.greenAccent
                : Colors.transparent,
            width: 2,
          ),
        ),
        fixedSize: Size(140, 140), // Büyütülmüş kare şekli için sabit boyut
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(height: 8),
          Text(
            activity,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}