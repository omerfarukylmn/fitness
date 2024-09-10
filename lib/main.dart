import 'package:fitness/screens/activityhistoryscreen/activity_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/screens/splash_screen/splash_screen.dart';
import 'package:fitness/screens/login_screen/login_screen.dart';
import 'package:fitness/screens/signup_screen/signup_screen.dart';
import 'package:fitness/screens/profile_screen/profile_screen.dart';
import 'package:fitness/screens/activity_screen/activity_screen.dart';
import 'package:fitness/screens/activity_summary_screen/activity_summary_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/profile': (context) => ProfileScreen(
              userName: 'Ömer Faruk Yelman',
              totalDistance: 26.5,
              totalTime: Duration(hours: 2, minutes: 30),
              activityCount: 15,
            ),
        '/activity': (context) => ActivityScreen(),
        '/activitySummary': (context) => ActivitySummaryScreen(activityId: 'activite_id', elapsedTime: Duration(hours: 1, minutes: 30)),
        '/activityHistory': (context) => ActivityHistoryScreen(),
      },
    );
  }
}