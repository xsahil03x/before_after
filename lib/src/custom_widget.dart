import 'package:before_after/src/rect_clipper.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BeforeAfter extends StatefulWidget {
  final Widget beforeImage;
  final Widget afterImage;
  final double imageHeight;
  final double imageWidth;
  final bool isVertical;
  final Color thumbColor;
  final double thumbRadius;

  const BeforeAfter({
    Key key,
    this.beforeImage,
    this.afterImage,
    this.imageHeight,
    this.imageWidth,
    this.isVertical = false,
    this.thumbColor = Colors.white,
    this.thumbRadius = 16.0,
  }) : super(key: key);

  @override
  _BeforeAfterState createState() => _BeforeAfterState();
}

class _BeforeAfterState extends State<BeforeAfter> {
  double _clipFactor = 0.5;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedImage(
          widget.afterImage,
          widget.imageHeight ?? null,
          widget.imageWidth,
        ),
        ClipPath(
          clipper: RectClipper(_clipFactor, widget.isVertical),
          child: SizedImage(
            widget.beforeImage,
            widget.imageHeight,
            widget.imageWidth,
          ),
        ),
        Positioned(
          top: 0.0,
          bottom: 0.0,
          right: 0.0,
          left: 0.0,
          child: Transform.rotate(
            angle: widget.isVertical ? math.pi / 2 : 0.0,
            child: SliderTheme(
              data: SliderThemeData(
                thumbShape:
                    CustomThumbShape(widget.thumbRadius, widget.thumbColor),
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
              ),
              child: Slider(
                value: _clipFactor,
                onChanged: (double factor) =>
                    setState(() => this._clipFactor = factor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SizedImage extends StatelessWidget {
  final Widget _image;
  final double _height, _width;

  const SizedImage(this._image, this._height, this._width, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: _image,
    );
  }
}

class CustomThumbShape extends SliderComponentShape {
  final double _thumbRadius;
  final Color _thumbColor;

  CustomThumbShape(this._thumbRadius, this._thumbColor);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(_thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      TextPainter labelPainter,
      RenderBox parentBox,
      SliderThemeData sliderTheme,
      TextDirection textDirection,
      double value}) {
    final Canvas canvas = context.canvas;

    final Paint paint = new Paint()
      ..isAntiAlias = true
      ..strokeWidth = 4.0
      ..color = _thumbColor
      ..style = PaintingStyle.fill;

    final Paint paintStroke = new Paint()
      ..isAntiAlias = true
      ..strokeWidth = 2.0
      ..color = _thumbColor
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      center,
      _thumbRadius,
      paintStroke,
    );

    canvas.drawCircle(
      center,
      _thumbRadius - 4,
      paint,
    );

    canvas.drawRect(
        Rect.fromCenter(
            center: center, width: 2.0, height: parentBox.size.height),
        paint);
  }
}
