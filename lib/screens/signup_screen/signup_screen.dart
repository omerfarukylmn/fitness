import 'package:flutter/material.dart';
import '../../styles/styles.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/orman.webp',
            fit: BoxFit.cover,
          ),
          Container(
            color: backgroundColor.withOpacity(0.5),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.directions_walk,
                  color: iconColor,
                  size: iconSize,
                ),
                SizedBox(height: 20),
                const Text(
                  'WalkTime',
                  textAlign: TextAlign.center,
                  style: titleTextStyle,
                ),
                SizedBox(height: 40),
                TextField(
                  decoration: textFieldDecoration.copyWith(hintText: 'Email'),
                  style: TextStyle(color: textColor),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: textFieldDecoration.copyWith(hintText: 'Password'),
                  style: TextStyle(color: textColor),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: buttonTextStyle,
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    "Already have an account? Log in",
                    style: linkTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}