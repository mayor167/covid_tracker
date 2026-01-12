import 'package:flutter_app_boilerplate/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:flutter_app_boilerplate/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class RRoundedStackedContainer extends StatelessWidget {
  const RRoundedStackedContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.circleColor,
    this.withCircle = true,
  });

  final Color? backgroundColor, circleColor;
  final Widget child;
  final bool withCircle;

  @override
  Widget build(BuildContext context) {
    final screenWidth = RHelperFunctions.screenWidth();

    return RRoundedContainer(
      backgroundColor: backgroundColor ?? RColors.primary,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(screenWidth / 30),
        child: Stack(
          children: [
            if (withCircle) ...[
              Positioned(
                top: screenWidth / 4.8,
                left: -screenWidth / 6,
                child: RCircularContainer(
                  width: screenWidth / 2,
                  height: screenWidth / 2,
                  radius: screenWidth / 2,
                  backgroundColor:
                      circleColor ?? RColors.textWhite.withAlpha(26),
                ),
              ),
              Positioned(
                top: screenWidth / 10,
                right: -screenWidth / 4.5,
                child: RCircularContainer(
                  width: screenWidth / 2,
                  height: screenWidth / 2,
                  radius: screenWidth / 2,
                  backgroundColor:
                      circleColor ?? RColors.textWhite.withAlpha(26),
                ),
              ),
            ],
            child,
          ],
        ),
      ),
    );
  }
}
