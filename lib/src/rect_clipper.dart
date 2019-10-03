import 'package:flutter/material.dart';

class RectClipper extends CustomClipper<Path> {
  final double clipFactor;

  RectClipper(this.clipFactor);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width * clipFactor, 0.0);
    path.lineTo(size.width * clipFactor, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class RectClipperVertical extends CustomClipper<Path> {
  final double clipFactor;

  RectClipperVertical(this.clipFactor);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height * clipFactor);
    path.lineTo(size.width, size.height * clipFactor);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
