import 'package:before_after/src/before_after_theme.dart';
import 'package:before_after/src/rect_clipper.dart';
import 'package:before_after/src/slider_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'two_directional_slider.dart';

const _defaultThumbElevation = 1.0;

/// The direction in which slider can be dragged.
enum SliderDirection {
  /// The slider can be dragged by dragging either left or right.
  horizontal,

  /// The slider can be dragged by dragging either up or down.
  vertical,
}

/// An interactive widget that allows comparing two images using a before and after view.
///
/// The [BeforeAfter] widget displays two images, [before] and [after], with a draggable slider in between.
/// The slider can be used to reveal or hide portions of the images, providing a comparison effect.
///
/// The [direction] determines the direction of the slider and can be either [SliderDirection.horizontal] or [SliderDirection.vertical].
/// The [value] specifies the initial position of the slider, ranging from 0.0 (fully hidden) to 1.0 (fully visible).
/// The [onValueChanged] callback is called when the value of the slider changes, providing the updated value.
///
/// The appearance of the slider can be customized using various properties:
///   - [thumbColor]: The color of the slider thumb.
///   - [thumbRadius]: The radius of the slider thumb.
///   - [overlayColor]: The color of the overlay when the images are revealed.
///   - [thumbImage]: The image to be displayed on the slider thumb.
///
/// The position of the slider thumb can be controlled using [thumbPosition].
/// The [onThumbPositionChanged] callback is called when the position of the thumb changes, providing the updated position.
///
/// Note: The [before] and [after] widgets should have the same size.
class BeforeAfter extends StatefulWidget {
  /// Creates a [BeforeAfter] widget with the specified before and after images.
  BeforeAfter({
    Key? key,
    required this.before,
    required this.after,
    this.height,
    this.width,
    this.trackWidth,
    this.trackColor,
    this.hideThumb = false,
    this.thumbHeight,
    this.thumbWidth,
    this.thumbColor,
    this.overlayColor,
    this.thumbDecoration,
    this.direction = SliderDirection.horizontal,
    this.value = 0.5,
    this.divisions,
    this.onValueChanged,
    this.thumbPosition = 0.5,
    this.thumbDivisions,
    this.onThumbPositionChanged,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
  })  : assert(thumbDecoration == null || thumbDecoration.debugAssertIsValid()),
        assert(
          thumbColor == null || thumbDecoration == null,
          'Cannot provide both a thumbColor and a thumbDecoration\n'
          'To provide both, use "thumbDecoration: BoxDecoration(color: thumbColor)".',
        ),
        super(key: key);

  /// The widget to be displayed before the slider.
  final Widget before;

  /// The widget to be displayed after the slider.
  final Widget after;

  /// The drag direction of the slider.
  final SliderDirection direction;

  /// The height of the BeforeAfter widget.
  final double? height;

  /// The width of the BeforeAfter widget.
  final double? width;

  /// The width of the slider track.
  final double? trackWidth;

  /// The color of the slider track.
  final Color? trackColor;

  /// Whether to hide the slider thumb.
  final bool hideThumb;

  /// The height of the slider thumb.
  final double? thumbHeight;

  /// The width of the slider thumb.
  final double? thumbWidth;

  /// The color of the slider thumb.
  ///
  /// This property should be preferred when the background is a simple color.
  /// For other cases, such as gradients or images, use the [thumbDecoration]
  /// property.
  ///
  /// If the [thumbDecoration] is used, this property must be null. A background
  /// color may still be painted by the [thumbDecoration] even if this property
  /// is null.
  final Color? thumbColor;

  /// The highlight color that's typically used to indicate that
  /// the slider thumb is focused.
  final WidgetStateProperty<Color?>? overlayColor;

  /// The decoration of the slider thumb.
  ///
  /// Use the [thumbColor] property to specify a simple solid color.
  final BoxDecoration? thumbDecoration;

  /// The number of discrete divisions on the slider.
  final int? divisions;

  /// The position of the slider, ranging from 0.0 to 1.0.
  final double value;

  /// A callback function that is called when the value of the slider changes.
  final ValueChanged<double>? onValueChanged;

  /// The number of discrete divisions on the slider thumb.
  final int? thumbDivisions;

  /// The position of the slider thumb, ranging from 0.0 to 1.0.
  final double thumbPosition;

  /// A callback function that is called when the position of the thumb changes.
  final ValueChanged<double>? onThumbPositionChanged;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@template flutter.material.slider.mouseCursor}
  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [WidgetStateProperty.resolve] is used for the following [WidgetState]s:
  ///
  ///  * [WidgetState.disabled].
  ///  * [WidgetState.dragged].
  ///  * [WidgetState.hovered].
  ///  * [WidgetState.focused].
  /// {@endtemplate}
  ///
  /// If null, then the value of [SliderThemeData.mouseCursor] is used. If that
  /// is also null, then [WidgetStateMouseCursor.clickable] is used.
  ///
  /// See also:
  ///
  ///  * [WidgetStateMouseCursor], which can be used to create a [MouseCursor]
  ///    that is also a [MaterialStateProperty<MouseCursor>].
  final MouseCursor? mouseCursor;

  @override
  State<BeforeAfter> createState() => _BeforeAfterState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Widget>('before', before));
    properties.add(DiagnosticsProperty<Widget>('after', after));
    properties.add(DoubleProperty('height', height));
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('trackWidth', trackWidth));
    properties.add(ColorProperty('trackColor', trackColor));
    properties.add(FlagProperty('hideThumb',
        value: hideThumb,
        ifTrue: 'thumb is hidden',
        ifFalse: 'thumb is shown',
        showName: true));
    properties.add(DoubleProperty('thumbHeight', thumbHeight));
    properties.add(DoubleProperty('thumbWidth', thumbWidth));
    properties.add(ColorProperty('thumbColor', thumbColor));
    properties.add(DiagnosticsProperty<WidgetStateProperty<Color?>>(
        'overlayColor', overlayColor));
    properties.add(DiagnosticsProperty<BoxDecoration>(
        'thumbDecoration', thumbDecoration,
        showName: false));
    properties.add(EnumProperty<SliderDirection>('direction', direction));
    properties.add(DoubleProperty('value', value));
    properties.add(IntProperty('divisions', divisions));
    properties.add(DoubleProperty('thumbPosition', thumbPosition));
    properties.add(IntProperty('thumbDivisions', thumbDivisions));
    properties.add(ObjectFlagProperty<ValueChanged<double>>.has(
        'onValueChanged', onValueChanged));
    properties.add(ObjectFlagProperty<ValueChanged<double>>.has(
        'onThumbPositionChanged', onThumbPositionChanged));
    properties
        .add(DiagnosticsProperty<MouseCursor>('mouseCursor', mouseCursor));
  }
}

class _BeforeAfterState extends State<BeforeAfter>
    with SingleTickerProviderStateMixin {
  final GlobalKey _sliderKey = GlobalKey();

  // Action mapping for a focused slider.
  late Map<Type, Action<Intent>> _actionMap;

  // Keyboard mapping for a focused slider.
  static const Map<ShortcutActivator, Intent> _traditionalNavShortcutMap = {
    SingleActivator(LogicalKeyboardKey.arrowUp): _AdjustSliderIntent.up(),
    SingleActivator(LogicalKeyboardKey.arrowDown): _AdjustSliderIntent.down(),
    SingleActivator(LogicalKeyboardKey.arrowLeft): _AdjustSliderIntent.left(),
    SingleActivator(LogicalKeyboardKey.arrowRight): _AdjustSliderIntent.right(),
  };

  // Keyboard mapping for a focused slider when using directional navigation.
  // The vertical inputs are not handled to allow navigating out of the slider.
  static const Map<ShortcutActivator, Intent> _directionalNavShortcutMap = {
    SingleActivator(LogicalKeyboardKey.arrowLeft): _AdjustSliderIntent.left(),
    SingleActivator(LogicalKeyboardKey.arrowRight): _AdjustSliderIntent.right(),
  };

  // The focus node of the slider.
  late FocusNode _focusNode;

  // Handle a potential change in focusNode by properly disposing of the old one
  // and setting up the new one, if needed.
  void _updateFocusNode(FocusNode? old, FocusNode? current) {
    if ((old == null && current == null) || old == current) {
      return;
    }
    if (old == null) {
      _focusNode.dispose();
      _focusNode = current!;
    } else if (current == null) {
      _focusNode = FocusNode();
    } else {
      _focusNode = current;
    }
  }

  // Animation controller that is run when the overlay (a.k.a radial reaction)
  // is shown in response to user interaction.
  late AnimationController _overlayController;

  // The painter that draws the slider.
  late final SliderPainter _painter;

  bool get _enabled =>
      widget.onValueChanged != null || widget.onThumbPositionChanged != null;

  // The current rect of the thumb.
  //
  // This is used to determine if the thumb is getting hovered by the mouse.
  Rect? _thumbRect;

  void _onHover(PointerHoverEvent event) {
    final isThumbHovered = _thumbRect?.contains(event.localPosition);
    if (isThumbHovered == null) return;

    if (_enabled && isThumbHovered) {
      // Only show overlay when pointer is hovering the thumb.
      _overlayController.forward();
    } else {
      // Only remove overlay when Slider is unfocused.
      if (!_focused) {
        _overlayController.reverse();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _overlayController = AnimationController(
      duration: kRadialReactionDuration,
      vsync: this,
    );
    _painter = SliderPainter(
      overlayAnimation: CurvedAnimation(
        parent: _overlayController,
        curve: Curves.fastOutSlowIn,
      ),
      onThumbRectChanged: (thumbRect) {
        _thumbRect = thumbRect;
      },
    );
    _actionMap = <Type, Action<Intent>>{
      _AdjustSliderIntent: CallbackAction<_AdjustSliderIntent>(
        onInvoke: _actionHandler,
      ),
    };
    // Only create a new node if the widget doesn't have one.
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(covariant BeforeAfter oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateFocusNode(oldWidget.focusNode, widget.focusNode);
  }

  @override
  void dispose() {
    _painter.dispose();
    _overlayController.dispose();
    super.dispose();
  }

  void _handleValueChanged(double value) {
    assert(widget.onValueChanged != null);
    if (value != widget.value) {
      widget.onValueChanged!(value);
      _focusNode.requestFocus();
    }
  }

  void _handleThumbPositionChanged(double value) {
    assert(widget.onThumbPositionChanged != null);
    if (value != widget.thumbPosition) {
      widget.onThumbPositionChanged!(value);
      _focusNode.requestFocus();
    }
  }

  void _actionHandler(_AdjustSliderIntent intent) {
    final slider = _sliderKey.currentState as _TwoDirectionalSliderState;
    final TextDirection textDirection = Directionality.of(context);
    switch (intent.type) {
      case _SliderAdjustmentType.right:
        switch (textDirection) {
          case TextDirection.rtl:
            return slider._decreaseHorizontalAction();
          case TextDirection.ltr:
            return slider._increaseHorizontalAction();
        }
      case _SliderAdjustmentType.left:
        switch (textDirection) {
          case TextDirection.rtl:
            return slider._increaseHorizontalAction();
          case TextDirection.ltr:
            return slider._decreaseHorizontalAction();
        }

      case _SliderAdjustmentType.up:
        return slider._decreaseVerticalAction();
      case _SliderAdjustmentType.down:
        return slider._increaseVerticalAction();
    }
  }

  bool _hovering = false;

  void _handleHoverChanged(bool hovering) {
    if (hovering != _hovering) {
      setState(() => _hovering = hovering);
    }
  }

  bool _focused = false;

  void _handleFocusHighlightChanged(bool focused) {
    if (focused != _focused) {
      setState(() => _focused = focused);
      if (focused) {
        _overlayController.forward();
      } else {
        _overlayController.reverse();
      }
    }
  }

  bool _dragging = false;

  void _handleDragStart(double _) {
    if (_dragging) return;
    setState(() => _dragging = true);
  }

  void _handleDragEnd(double _) {
    if (!_dragging) return;
    setState(() => _dragging = false);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final beforeAfterTheme = BeforeAfterTheme.of(context);
    final defaults = theme.useMaterial3
        ? _BeforeAfterDefaultsM3(context)
        : _BeforeAfterDefaultsM2(context);

    final effectiveTrackWidth = widget.trackWidth ??
        beforeAfterTheme.trackWidth ??
        defaults.trackWidth!;

    final effectiveTrackColor = widget.trackColor ??
        beforeAfterTheme.trackColor ??
        defaults.trackColor!;

    final effectiveThumbHeight = widget.thumbHeight ??
        beforeAfterTheme.thumbHeight ??
        defaults.thumbHeight!;

    final effectiveThumbWidth = widget.thumbWidth ??
        beforeAfterTheme.thumbWidth ??
        defaults.thumbWidth!;

    final effectiveThumbDecoration = (widget.thumbDecoration ??
            beforeAfterTheme.thumbDecoration ??
            defaults.thumbDecoration!)
        .copyWith(color: widget.thumbColor);

    final isXAxis = widget.direction == SliderDirection.horizontal;

    final onHorizontalChanged =
        widget.onValueChanged != null ? _handleValueChanged : null;

    final onVerticalChanged = widget.onThumbPositionChanged != null
        ? _handleThumbPositionChanged
        : null;

    final before = SizedBox(
        width: widget.width, height: widget.height, child: widget.before);

    final after = SizedBox(
        width: widget.width, height: widget.height, child: widget.after);

    final Map<ShortcutActivator, Intent> shortcutMap;
    switch (MediaQuery.navigationModeOf(context)) {
      case NavigationMode.directional:
        shortcutMap = _directionalNavShortcutMap;
        break;
      case NavigationMode.traditional:
        shortcutMap = _traditionalNavShortcutMap;
        break;
    }

    final states = {
      if (!_enabled) WidgetState.disabled,
      if (_focused) WidgetState.focused,
      if (_hovering) WidgetState.hovered,
      if (_dragging) WidgetState.dragged,
    };

    final effectiveOverlayColor = widget.overlayColor?.resolve(states) ??
        widget.trackColor?.withOpacity(0.12) ??
        WidgetStateProperty.resolveAs<Color?>(
            beforeAfterTheme.overlayColor, states) ??
        WidgetStateProperty.resolveAs<Color>(defaults.overlayColor!, states);

    final effectiveMouseCursor =
        WidgetStateProperty.resolveAs(widget.mouseCursor, states) ??
            beforeAfterTheme.mouseCursor?.resolve(states) ??
            WidgetStateMouseCursor.clickable.resolve(states);

    VoidCallback? handleDidGainAccessibilityFocus;
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
        break;
      case TargetPlatform.windows:
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the slider when it receives a11y focus.
          if (!_focusNode.hasFocus && _focusNode.canRequestFocus) {
            _focusNode.requestFocus();
          }
        };
    }

    return Semantics(
      container: true,
      slider: true,
      onDidGainAccessibilityFocus: handleDidGainAccessibilityFocus,
      child: MouseRegion(
        // Only used because we want to show the overlay when the mouse is
        // hovering the thumb. This is not possible with FocusableActionDetector
        // because it does not provides `PointerHoverEvent`.
        onHover: _onHover,
        child: FocusableActionDetector(
          actions: _actionMap,
          shortcuts: shortcutMap,
          focusNode: _focusNode,
          autofocus: widget.autofocus,
          onShowFocusHighlight: _handleFocusHighlightChanged,
          onShowHoverHighlight: _handleHoverChanged,
          mouseCursor: effectiveMouseCursor,
          child: TwoDirectionalSlider(
            key: _sliderKey,
            initialHorizontalValue: widget.value,
            initialVerticalValue: widget.thumbPosition,
            verticalDivisions:
                isXAxis ? widget.thumbDivisions : widget.divisions,
            horizontalDivisions:
                isXAxis ? widget.divisions : widget.thumbDivisions,
            onVerticalChangeStart: _handleDragStart,
            onVerticalChanged:
                isXAxis ? onVerticalChanged : onHorizontalChanged,
            onVerticalChangeEnd: _handleDragEnd,
            onHorizontalChangeStart: _handleDragStart,
            onHorizontalChanged:
                isXAxis ? onHorizontalChanged : onVerticalChanged,
            onHorizontalChangeEnd: _handleDragEnd,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                before,
                ClipRect(
                  clipper: RectClipper(
                    direction: widget.direction,
                    clipFactor: widget.value,
                  ),
                  child: after,
                ),
                CustomPaint(
                  painter: _painter
                    ..axis = widget.direction
                    ..value = widget.value
                    ..trackWidth = effectiveTrackWidth
                    ..trackColor = effectiveTrackColor
                    ..hideThumb = widget.hideThumb
                    ..thumbValue = widget.thumbPosition
                    ..thumbHeight = effectiveThumbHeight
                    ..thumbWidth = effectiveThumbWidth
                    ..overlayColor = effectiveOverlayColor
                    ..configuration = createLocalImageConfiguration(context)
                    ..thumbDecoration = effectiveThumbDecoration,
                  child: Hide(child: after),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A widget that hides its child widget from being visible.
class Hide extends StatelessWidget {
  /// Creates a [Hide] widget with the specified child.
  const Hide({
    Key? key,
    required this.child,
  }) : super(key: key);

  /// The child widget to be hidden.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: child,
    );
  }
}

class _AdjustSliderIntent extends Intent {
  const _AdjustSliderIntent({required this.type});

  const _AdjustSliderIntent.right() : type = _SliderAdjustmentType.right;

  const _AdjustSliderIntent.left() : type = _SliderAdjustmentType.left;

  const _AdjustSliderIntent.up() : type = _SliderAdjustmentType.up;

  const _AdjustSliderIntent.down() : type = _SliderAdjustmentType.down;

  final _SliderAdjustmentType type;
}

enum _SliderAdjustmentType { right, left, up, down }

class _BeforeAfterDefaultsM2 extends BeforeAfterTheme {
  _BeforeAfterDefaultsM2(BuildContext context)
      : _colors = Theme.of(context).colorScheme,
        super(trackWidth: 6.0, thumbWidth: 24.0, thumbHeight: 24.0);

  final ColorScheme _colors;

  @override
  Color get trackColor => _colors.primary;

  @override
  Color get overlayColor => _colors.primary.withOpacity(0.12);

  @override
  BoxDecoration get thumbDecoration {
    return BoxDecoration(
      color: trackColor,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: _defaultThumbElevation,
          spreadRadius: _defaultThumbElevation / 2,
          offset: const Offset(0, _defaultThumbElevation / 2),
        ),
      ],
    );
  }
}

class _BeforeAfterDefaultsM3 extends BeforeAfterTheme {
  _BeforeAfterDefaultsM3(BuildContext context)
      : _colors = Theme.of(context).colorScheme,
        super(trackWidth: 6.0, thumbWidth: 24.0, thumbHeight: 24.0);

  final ColorScheme _colors;

  @override
  Color get trackColor => _colors.primary;

  @override
  Color get overlayColor {
    return WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return _colors.primary.withOpacity(0.08);
      }
      if (states.contains(WidgetState.focused)) {
        return _colors.primary.withOpacity(0.12);
      }
      if (states.contains(WidgetState.dragged)) {
        return _colors.primary.withOpacity(0.12);
      }

      return Colors.transparent;
    });
  }

  @override
  BoxDecoration get thumbDecoration {
    return BoxDecoration(
      color: trackColor,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: _defaultThumbElevation,
          spreadRadius: _defaultThumbElevation / 2,
          offset: const Offset(0, _defaultThumbElevation / 2),
        ),
      ],
    );
  }
}
