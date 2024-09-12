import 'package:flutter/material.dart';

class CountdownWidget extends StatelessWidget {
  final int countdown;

  CountdownWidget({required this.countdown});

  @override
  Widget build(BuildContext context) {
    return countdown < 3
        ? Container(
            color: Colors.black,
            child: Center(
              child: Text(
                '$countdown',
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          )
        : Container();
  }
}