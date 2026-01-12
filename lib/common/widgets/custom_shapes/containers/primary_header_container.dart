import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

class RPrimaryHeaderContainer extends StatelessWidget {
  const RPrimaryHeaderContainer({
    super.key,
    required this.child,
    this.useCurves = true,
  });

  final Widget child;
  final bool useCurves;

  @override
  Widget build(BuildContext context) {
    return useCurves
        ? RCurvedEdgesWidget(
            child: DhisContainer(child: child),
          )
        : DhisContainer(child: child);
  }
}

class DhisContainer extends StatelessWidget {
  const DhisContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RColors.primary,
      child: Stack(
        children: [
          Positioned(
              top: -150,
              right: -250,
              child: RCircularContainer(
                backgroundColor: RColors.textWhite.withAlpha(26),
              )),
          Positioned(
              top: 100,
              right: -300,
              child: RCircularContainer(
                backgroundColor: RColors.textWhite.withAlpha(26),
              )),
          child
        ],
      ),
    );
  }
}
