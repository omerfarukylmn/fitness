import 'package:flutter/material.dart';

class CountdownWidget extends StatelessWidget {
  final int countdown;

  const CountdownWidget({super.key, required this.countdown});

  @override
  Widget build(BuildContext context) {
    return countdown < 3
        ? Container(
            color: Colors.black,
            child: Center(
              child: Text(
                '$countdown',
                style: const TextStyle(
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