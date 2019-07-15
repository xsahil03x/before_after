import 'package:flutter/material.dart';

class RectClipper extends CustomClipper<Path> {
  final double clipFactor;
  final bool isVertical;

  RectClipper(this.clipFactor, this.isVertical);

  @override
  Path getClip(Size size) {
    Path path = Path();
    if (isVertical) {
      path.lineTo(0.0, size.height * clipFactor);
      path.lineTo(size.width, size.height * clipFactor);
      path.lineTo(size.width, 0);
    } else {
      path.lineTo(size.width * clipFactor, 0.0);
      path.lineTo(size.width * clipFactor, size.height);
      path.lineTo(0.0, size.height);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
