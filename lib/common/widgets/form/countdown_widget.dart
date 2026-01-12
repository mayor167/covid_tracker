import 'package:flutter/material.dart';

class CountdownText extends StatelessWidget {
  const CountdownText({super.key, required this.initialSeconds});

  final int initialSeconds;

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatTime(initialSeconds),
      style: const TextStyle(fontSize: 16),
    );
  }
}
