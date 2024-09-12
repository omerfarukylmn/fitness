import 'package:fitness/screens/widgets/activity_button.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fitness/screens/activity_in/activity_in_progress_screen.dart';
import 'package:fitness/widgets/activity_button.dart';
import 'package:fitness/utils/countdown_widget.dart';

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
                    ActivityButton(activity: 'Running', icon: Icons.directions_run, isSelected: selectedActivity == 'Running', onSelect: () => _selectActivity('Running')),
                    ActivityButton(activity: 'Cycling', icon: Icons.directions_bike, isSelected: selectedActivity == 'Cycling', onSelect: () => _selectActivity('Cycling')),
                    ActivityButton(activity: 'Swimming', icon: Icons.pool, isSelected: selectedActivity == 'Swimming', onSelect: () => _selectActivity('Swimming')),
                    ActivityButton(activity: 'Walking', icon: Icons.directions_walk, isSelected: selectedActivity == 'Walking', onSelect: () => _selectActivity('Walking')),
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
                CountdownWidget(countdown: countdown),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectActivity(String activity) {
    setState(() {
      selectedActivity = activity;
    });
  }
}