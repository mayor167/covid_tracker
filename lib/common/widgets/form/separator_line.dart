import 'package:flutter/material.dart';

class RSeparatorLineWidget extends StatelessWidget {
  const RSeparatorLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40, // Adjust height to match row height
      width: 1.5,
      color: Colors.grey.shade300,
    );
  }
}
