import 'package:flutter/material.dart';

import '../before_after.dart';

/// A custom clipper that clips a rectangular region based on the provided direction and clip factor.
///
/// The [RectClipper] is used to clip a rectangular region within a widget.
/// The clipping can be controlled by specifying the [direction] and [clipFactor].
///
/// The [direction] determines the direction of clipping and can be either [SliderDirection.horizontal] or [SliderDirection.vertical].
/// For the horizontal direction, the clipping width is calculated as the product of the widget's width and the [clipFactor].
/// For the vertical direction, the clipping height is calculated as the product of the widget's height and the [clipFactor].
///
/// The [clipFactor] specifies the fraction of the widget's size that should be clipped.
/// It should be a value between 0.0 and 1.0, where 0.0 indicates no clipping and 1.0 indicates full clipping.
class RectClipper extends CustomClipper<Rect> {
  /// Creates a [RectClipper] with the specified direction and clip factor.
  const RectClipper({
    required this.direction,
    required this.clipFactor,
  });

  /// The direction in which the clipping should occur.
  final SliderDirection direction;

  /// The fraction of the widget's size to be clipped.
  final double clipFactor;

  @override
  Rect getClip(Size size) {
    final rect = Rect.fromLTWH(
      0.0,
      0.0,
      direction == SliderDirection.horizontal
          ? size.width * clipFactor
          : size.width,
      direction == SliderDirection.vertical
          ? size.height * clipFactor
          : size.height,
    );

    return rect;
  }

  @override
  bool shouldReclip(RectClipper oldClipper) =>
      oldClipper.clipFactor != clipFactor || oldClipper.direction != direction;
}
