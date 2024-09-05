import 'package:flutter/material.dart';

// Renkler
const Color backgroundColor = Colors.black;
const Color iconColor = Colors.white;
const Color textColor = Colors.white;
const Color buttonColor = Color.fromARGB(255, 23, 128, 67);
const Color textFieldFillColor = Colors.white70;

// Metin Stili
const TextStyle titleTextStyle = TextStyle(
  color: textColor,
  fontSize: 32,
  fontWeight: FontWeight.bold,
);

const TextStyle hintTextStyle = TextStyle(
  color: textFieldFillColor,
  fontWeight: FontWeight.w800,
  fontSize: 18,
);

const TextStyle buttonTextStyle = TextStyle(
  color: textColor,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const TextStyle linkTextStyle = TextStyle(
  color: textColor,
  fontSize: 16,
  decoration: TextDecoration.underline,
);

// İkon Stili
const double iconSize = 80.0;

// TextField Stili
final InputDecoration textFieldDecoration = InputDecoration(
  hintStyle: hintTextStyle,
  filled: true,
  fillColor: Colors.white.withOpacity(0.45),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  ),
);