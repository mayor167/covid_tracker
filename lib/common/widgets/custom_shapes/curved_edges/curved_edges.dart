import 'package:flutter/cupertino.dart';

class RCustomeCurvedEdges extends CustomClipper<Path> {
@override
Path getClip(Size size) {
  var path = Path();
  
  // Move to the top-left corner
  path.lineTo(0, size.height - 15);

  // Bottom-left corner curve with balanced control and end points
  final bottomLeftControlPoint = Offset(0, size.height);
  final bottomLeftEndPoint = Offset(20, size.height);
  path.quadraticBezierTo(
    bottomLeftControlPoint.dx,
    bottomLeftControlPoint.dy,
    bottomLeftEndPoint.dx,
    bottomLeftEndPoint.dy,
  );

  // Draw a line across the bottom
  path.lineTo(size.width - 20, size.height);

  // Bottom-right corner curve with mirrored control and end points
  final bottomRightControlPoint = Offset(size.width, size.height);
  final bottomRightEndPoint = Offset(size.width, size.height - 20);
  path.quadraticBezierTo(
    bottomRightControlPoint.dx,
    bottomRightControlPoint.dy,
    bottomRightEndPoint.dx,
    bottomRightEndPoint.dy,
  );

  // Draw the right edge back to the top
  path.lineTo(size.width, 0);
  path.close();

  return path;
}



  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
