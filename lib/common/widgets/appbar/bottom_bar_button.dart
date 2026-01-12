import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BottomBarButton extends StatelessWidget {
  const BottomBarButton({super.key, this.onPressed, this.text, this.child});

  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: RSizes.defaultSpace * 2,
          left: RSizes.defaultSpace,
          right: RSizes.defaultSpace),
      child: ElevatedButton(
          onPressed: onPressed, child: (child) != null ? child : Text(text!)),
    );
  }
}
