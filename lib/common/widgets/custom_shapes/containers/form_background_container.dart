import 'package:flutter_app_boilerplate/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class RFormBackgroundContainer extends StatelessWidget {
  const RFormBackgroundContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: -150,
            right: -200,
            child: RCircularContainer(
              backgroundColor: RColors.primary.withAlpha(51),
            )),
        Positioned(
            top: 100,
            right: -300,
            child: RCircularContainer(
              backgroundColor: RColors.primary.withAlpha(26),
            )),
        child
      ],
    );
  }
}
