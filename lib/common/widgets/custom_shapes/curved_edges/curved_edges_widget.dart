import 'package:flutter/material.dart';

import 'curved_edges.dart';

class RCurvedEdgesWidget extends StatelessWidget {
  const RCurvedEdgesWidget({
    super.key, this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RCustomeCurvedEdges(),
      child: child,
    );
  }
}