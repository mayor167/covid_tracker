import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class RCircularIcon extends StatelessWidget {
  const RCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = RSizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed, 
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color, backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor != null
            ? backgroundColor!
            : RHelperFunctions.isDarkMode(context)
                ? RColors.black.withAlpha(26)
                : RColors.white.withAlpha(230),
      ),
      child: IconButton(onPressed: onPressed, icon: Icon(icon, color: color, size: size,)),
    );
  }
}
