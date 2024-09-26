import 'package:fitness/widgets/splash_content.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../styles/styles.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Belirli bir süre sonra giriş ekranına yönlendirme
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SplashContent(),
      ),
    );
  }
}