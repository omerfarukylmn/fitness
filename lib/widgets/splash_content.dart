import 'package:flutter/material.dart';
import '../../styles/styles.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
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