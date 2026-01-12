// splash_screen.dart
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/loaders/mytrader-gggif.gif',
          width: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }
}
