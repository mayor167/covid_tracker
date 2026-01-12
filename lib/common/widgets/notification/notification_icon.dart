
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RNotificationIcon extends StatelessWidget {
  const RNotificationIcon({
    super.key,
    this.onPressed,
    required this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
  });

  final VoidCallback? onPressed;
  final Color? iconColor, counterBgColor, counterTextColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Iconsax.notification_bing5,
        color: iconColor,
      ),
    );
  }
}
