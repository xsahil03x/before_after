import 'package:before_after/src/rect_clipper.dart';
import 'package:flutter/material.dart';

class BeforeAfter extends StatefulWidget {
  final Widget beforeImage;
  final Widget afterImage;
  final double imageHeight;
  final double imageWidth;
  final double imageCornerRadius;
  final Color thumbColor;
  final double thumbRadius;
  final Color overlayColor;
  final bool isVertical;
  final Duration duration;
  final bool autoAnimation;
  final bool repeatAnimation;
  final Curve curve;
  final bool visibleSeparation;

  const BeforeAfter({
    Key key,
    @required this.beforeImage,
    @required this.afterImage,
    this.imageHeight,
    this.imageWidth,
    this.imageCornerRadius = 8.0,
    this.thumbColor = Colors.white,
    this.thumbRadius = 16.0,
    this.overlayColor,
    this.isVertical = false,
    this.duration = const Duration(milliseconds: 1900),
    this.autoAnimation = false,
    this.repeatAnimation = false,
    this.curve = Curves.easeInOutCubic,
    this.visibleSeparation = true,
  })  : assert(beforeImage != null),
        assert(afterImage != null),
        super(key: key);

  @override
  _BeforeAfterState createState() => _BeforeAfterState();
}

class _BeforeAfterState extends State<BeforeAfter>
    with SingleTickerProviderStateMixin {
  double _clipFactor = 0.5;
  double _endValue = 1.0;
  bool _autoAnimation;

  @override
  void initState() {
    _autoAnimation = widget.autoAnimation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      curve: widget.curve,
      tween: _autoAnimation
          ? Tween<double>(
              begin: 0.0,
              end: _endValue,
            )
          : Tween<double>(
              begin: 0.5,
              end: 0.5,
            ),
      duration: widget.duration,
      onEnd: () {
        if (widget.repeatAnimation) {
          _endValue == 1.0 ? _endValue = 0.0 : _endValue = 1.0;
          setState(() {});
        } else {
          _clipFactor = 1.0;
          _autoAnimation = false;
        }
      },
      builder: (_, value, child) {
        if (_autoAnimation) _clipFactor = value;
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: widget.isVertical
                  ? const EdgeInsets.symmetric(vertical: 24.0)
                  : const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedImage(
                widget.afterImage,
                widget.imageHeight,
                widget.imageWidth,
                widget.imageCornerRadius,
              ),
            ),
            Padding(
              padding: widget.isVertical
                  ? const EdgeInsets.symmetric(vertical: 24.0)
                  : const EdgeInsets.symmetric(horizontal: 24.0),
              child: ClipPath(
                clipper: widget.isVertical
                    ? RectClipperVertical(_clipFactor)
                    : RectClipper(_clipFactor),
                child: SizedImage(
                  widget.beforeImage,
                  widget.imageHeight,
                  widget.imageWidth,
                  widget.imageCornerRadius,
                ),
              ),
            ),
            Positioned.fill(
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: 0.0,
                  overlayColor: widget.overlayColor,
                  thumbShape: widget.visibleSeparation
                      ? CustomThumbShape(widget.thumbRadius, widget.thumbColor)
                      : EmptyShape(
                          widget.thumbRadius,
                        ),
                ),
                child: widget.isVertical
                    ? RotatedBox(
                        quarterTurns: 1,
                        child: Slider(
                          value: _clipFactor,
                          onChanged: (double factor) =>
                              setState(() => this._clipFactor = factor),
                        ),
                      )
                    : Slider(
                        value: _clipFactor,
                        onChanged: (double factor) =>
                            setState(() => this._clipFactor = factor),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SizedImage extends StatelessWidget {
  final Widget _image;
  final double _height, _width, _imageCornerRadius;

  const SizedImage(
      this._image, this._height, this._width, this._imageCornerRadius,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_imageCornerRadius),
      child: SizedBox(
        height: _height,
        width: _width,
        child: _image,
      ),
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
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 4.0
      ..color = _thumbColor
      ..style = PaintingStyle.fill;

    final Paint paintStroke = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 4.0
      ..color = _thumbColor
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      center,
      _thumbRadius,
      paintStroke,
    );

    canvas.drawCircle(
      center,
      _thumbRadius - 6,
      paint,
    );

    canvas.drawRect(
      Rect.fromCenter(
        center: center,
        width: 4.0,
        height: parentBox.size.height,
      ),
      paint,
    );
  }
}

class EmptyShape extends SliderComponentShape {
  final double _thumbRadius;

  EmptyShape(
    this._thumbRadius,
  );

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(_thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 4.0
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromCenter(
        center: center,
        width: 4.0,
        height: parentBox.size.height,
      ),
      paint,
    );
  }
}
