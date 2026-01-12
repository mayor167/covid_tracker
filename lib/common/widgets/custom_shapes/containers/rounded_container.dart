import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';


class RRoundedContainer extends StatelessWidget {
   const RRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = RSizes.cardRadiusLg,
    this.child,
    this.showBorder = false,
    this.borderColor = RColors.borderPrimary,
    this.backgroundColor = RColors.white,
    this.padding,
    this.margin, 
    this.borderWidth = 1,
  });

  final double? width, height;
  final double radius;
  final double borderWidth;
  final Widget? child;
  final bool showBorder;
  final Color borderColor, backgroundColor;
  final EdgeInsetsGeometry? padding, margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor, width: borderWidth) : null),
      child: child,
    );
  }
}
