part of 'before_after.dart';

/// A widget that allows interactive two-directional sliding gestures.
///
/// The `TwoDirectionalSlider` widget wraps a child widget and allows users to perform sliding gestures
/// both vertically and horizontally. It can be configured with callbacks to notify the parent widget
/// about the changes in the vertical and horizontal values.
///
/// The vertical sliding gesture is handled through the [onVerticalChanged] callback, which receives
/// a [double] value representing the current vertical position. The [verticalDivisions] property can
/// be used to discretize the vertical values into a specified number of divisions.
///
/// The horizontal sliding gesture is handled through the [onHorizontalChanged] callback, which receives
/// a [double] value representing the current horizontal position. The [horizontalDivisions] property can
/// be used to discretize the horizontal values into a specified number of divisions.
///
/// Example usage:
///
/// ```dart
/// TwoDirectionalSlider(
///   onVerticalChanged: (value) {
///     // Handle vertical value changes
///   },
///   onHorizontalChanged: (value) {
///     // Handle horizontal value changes
///   },
///   child: Container(
///     // Child widget
///   ),
/// )
/// ```
class TwoDirectionalSlider extends StatefulWidget {
  /// Creates a two-directional slider.
  ///
  /// The [child] parameter must not be null.
  const TwoDirectionalSlider({
    super.key,
    required this.child,
    this.initialVerticalValue = 0.0,
    this.initialHorizontalValue = 0.0,
    this.onVerticalChangeStart,
    this.onVerticalChanged,
    this.onVerticalChangeEnd,
    this.verticalDivisions,
    this.onHorizontalChangeStart,
    this.onHorizontalChanged,
    this.onHorizontalChangeEnd,
    this.horizontalDivisions,
  });

  /// The child widget wrapped by the slider.
  final Widget child;

  /// The initial vertical drag value.
  final double initialVerticalValue;

  /// The initial horizontal drag value.
  final double initialHorizontalValue;

  /// Called when the vertical value starts changing.
  final ValueChanged<double>? onVerticalChangeStart;

  /// Called when the vertical value changes.
  final ValueChanged<double>? onVerticalChanged;

  /// Called when the vertical value stops changing.
  final ValueChanged<double>? onVerticalChangeEnd;

  /// The number of divisions to discretize the vertical values.
  ///
  /// If null, the vertical values are continuous.
  final int? verticalDivisions;

  /// Called when the horizontal value starts changing.
  final ValueChanged<double>? onHorizontalChangeStart;

  /// Called when the horizontal value changes.
  final ValueChanged<double>? onHorizontalChanged;

  /// Called when the horizontal value stops changing.
  final ValueChanged<double>? onHorizontalChangeEnd;

  /// The number of divisions to discretize the horizontal values.
  ///
  /// If null, the horizontal values are continuous.
  final int? horizontalDivisions;

  @override
  State<TwoDirectionalSlider> createState() => _TwoDirectionalSliderState();
}

class _TwoDirectionalSliderState extends State<TwoDirectionalSlider> {
  late double _currentVerticalDragValue;
  late double _currentHorizontalDragValue;

  bool _active = false;

  double _convertVerticalValue(double value) {
    if (widget.verticalDivisions != null) {
      return _discretizeVertical(value);
    }
    return value;
  }

  double _convertHorizontalValue(double value) {
    if (widget.horizontalDivisions != null) {
      return _discretizeHorizontal(value);
    }
    return value;
  }

  @override
  void initState() {
    super.initState();
    _currentVerticalDragValue =
        _convertVerticalValue(widget.initialVerticalValue);
    _currentHorizontalDragValue =
        _convertHorizontalValue(widget.initialHorizontalValue);
  }

  @override
  void didUpdateWidget(covariant TwoDirectionalSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialVerticalValue != widget.initialVerticalValue) {
      _currentVerticalDragValue =
          _convertVerticalValue(widget.initialVerticalValue);
    }
    if (oldWidget.initialHorizontalValue != widget.initialHorizontalValue) {
      _currentHorizontalDragValue =
          _convertHorizontalValue(widget.initialHorizontalValue);
    }
  }

  /// Returns true if the vertical sliding is interactive.
  bool get isVerticalInteractive => widget.onVerticalChanged != null;

  /// Returns true if the horizontal sliding is interactive.
  bool get isHorizontalInteractive => widget.onHorizontalChanged != null;

  /// Returns true if the slider is interactive.
  bool get isInteractive => isVerticalInteractive || isHorizontalInteractive;

  /// Converts the visual position to a value based on the text direction.
  double _getValueFromVisualPosition(double visualPosition) {
    final textDirection = Directionality.of(context);
    switch (textDirection) {
      case TextDirection.rtl:
        return 1.0 - visualPosition;
      case TextDirection.ltr:
        return visualPosition;
    }
  }

  /// Converts the local position to a vertical value.
  double _getVerticalValueFromLocalPosition(Offset globalPosition) {
    final box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(globalPosition);
    final visualPosition = localPosition.dy / box.size.height;
    return _getValueFromVisualPosition(visualPosition);
  }

  /// Converts the local position to a horizontal value.
  double _getHorizontalValueFromLocalPosition(Offset globalPosition) {
    final box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(globalPosition);
    final visualPosition = localPosition.dx / box.size.width;
    return _getValueFromVisualPosition(visualPosition);
  }

  /// Discretizes the vertical value based on the number of divisions.
  double _discretizeVertical(double value) {
    double result = clampDouble(value, 0.0, 1.0);
    if (widget.verticalDivisions != null) {
      final divisions = widget.verticalDivisions!;
      result = (result * divisions).round() / divisions;
    }
    return result;
  }

  /// Discretizes the horizontal value based on the number of divisions.
  double _discretizeHorizontal(double value) {
    double result = clampDouble(value, 0.0, 1.0);
    if (widget.horizontalDivisions != null) {
      final divisions = widget.horizontalDivisions!;
      result = (result * divisions).round() / divisions;
    }
    return result;
  }

  void _updateAndCallHorizontalChanged(double value) {
    _currentHorizontalDragValue = value;
    widget.onHorizontalChanged?.call(value);
    // _focusNode.requestFocus();
  }

  void _updateAndCallVerticalChanged(double value) {
    _currentVerticalDragValue = value;
    widget.onVerticalChanged?.call(value);
    // _focusNode.requestFocus();
  }

  void _startInteraction(Offset globalPosition) {
    if (!_active && isInteractive) {
      _active = true;
      // We supply the *current* value as the start location, so that if we have
      // a tap, it consists of a call to onChangeStart with the previous value and
      // a call to onChangeEnd with the new value.
      final vValue = _discretizeVertical(_currentVerticalDragValue);
      widget.onVerticalChangeStart?.call(vValue);

      final hValue = _discretizeHorizontal(_currentHorizontalDragValue);
      widget.onHorizontalChangeStart?.call(hValue);

      return _handleGesture(globalPosition);
    }
  }

  void _endInteraction() {
    if (!mounted) return;

    if (_active && mounted) {
      final vValue = _discretizeVertical(_currentVerticalDragValue);
      widget.onVerticalChangeEnd?.call(vValue);

      final hValue = _discretizeHorizontal(_currentHorizontalDragValue);
      widget.onHorizontalChangeEnd?.call(hValue);

      _active = false;
    }
  }

  void _onTapDown(TapDownDetails details) =>
      _startInteraction(details.globalPosition);

  void _onTapUp(TapUpDetails details) => _endInteraction();

  void _onPanStart(DragStartDetails details) =>
      _startInteraction(details.globalPosition);

  /// Handles the pan update gesture.
  void _onPanUpdate(DragUpdateDetails details) =>
      _handleGesture(details.globalPosition);

  void _onPanEnd(DragEndDetails details) => _endInteraction();

  /// Handles the sliding gesture.
  void _handleGesture(Offset globalPosition) {
    if (!mounted) return;

    if (isVerticalInteractive) {
      final value = _getVerticalValueFromLocalPosition(globalPosition);
      _updateAndCallVerticalChanged(_discretizeVertical(value));
    }

    if (isHorizontalInteractive) {
      final value = _getHorizontalValueFromLocalPosition(globalPosition);
      _updateAndCallHorizontalChanged(_discretizeHorizontal(value));
    }
  }

  double get _adjustmentUnit {
    final platform = Theme.of(context).platform;
    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        // Matches iOS implementation of material slider.
        return 0.1;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        // Matches Android implementation of material slider.
        return 0.05;
    }
  }

  double get _semanticHorizontalActionUnit {
    final divisions = widget.horizontalDivisions;
    return divisions != null ? 1.0 / divisions : _adjustmentUnit;
  }

  double get _semanticVerticalActionUnit {
    final divisions = widget.verticalDivisions;
    return divisions != null ? 1.0 / divisions : _adjustmentUnit;
  }

  void _increaseHorizontalAction() {
    if (isHorizontalInteractive) {
      final value = _currentHorizontalDragValue;
      _updateAndCallHorizontalChanged(
        clampDouble(value + _semanticHorizontalActionUnit, 0.0, 1.0),
      );
    }
  }

  void _decreaseHorizontalAction() {
    if (isHorizontalInteractive) {
      final value = _currentHorizontalDragValue;
      _updateAndCallHorizontalChanged(
        clampDouble(value - _semanticHorizontalActionUnit, 0.0, 1.0),
      );
    }
  }

  void _increaseVerticalAction() {
    if (isVerticalInteractive) {
      final value = _currentVerticalDragValue;
      _updateAndCallVerticalChanged(
        clampDouble(value + _semanticVerticalActionUnit, 0.0, 1.0),
      );
    }
  }

  void _decreaseVerticalAction() {
    if (isVerticalInteractive) {
      final value = _currentVerticalDragValue;
      _updateAndCallVerticalChanged(
        clampDouble(value - _semanticVerticalActionUnit, 0.0, 1.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: widget.child,
    );
  }
}
