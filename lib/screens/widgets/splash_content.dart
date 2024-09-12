import 'package:flutter/material.dart';
import '../../styles/styles.dart';

class SplashContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}