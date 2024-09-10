import 'package:flutter/material.dart';
import 'dart:async';
import '../../styles/styles.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_walk,
              color: iconColor,
              size: iconSize,
            ),
            SizedBox(height: 20),
            Text(
              'WalkTime',
              style: titleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}