import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class RCircularLoader extends StatelessWidget {
  const RCircularLoader({super.key, this.backgroundColor});
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: const Center(
          child: CircularProgressIndicator(color: RColors.primary)),
    );
  }
}
