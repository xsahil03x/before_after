import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A theme extension class that defines custom styling and behavior for the
/// BeforeAfter widget.
///
/// Use the `BeforeAfterTheme` to customize the appearance and behavior of
/// the BeforeAfter widget throughout your app. The theme properties can be
/// accessed using `BeforeAfterTheme.of(context)`. By default, the theme's
/// properties will be used. To override specific properties, use the
/// `BeforeAfterThemeData.copyWith` method to create a new instance of the
/// theme with the desired changes.
///
/// See also:
///
///   * [BeforeAfterThemeData], which is used to define the actual theme data.
///   * [BeforeAfter], which uses the `BeforeAfterTheme` to apply the styling
///     defined in the theme data.
class BeforeAfterTheme extends ThemeExtension<BeforeAfterTheme>
    with DiagnosticableTreeMixin {
  /// Creates a BeforeAfterTheme.
  ///
  /// The [trackWidth], [trackColor], [thumbHeight], [thumbWidth], [overlayColor],
  /// [thumbDecoration], and [mouseCursor] parameters can be used to customize
  /// the appearance and behavior of the theme.
  const BeforeAfterTheme({
    this.trackWidth,
    this.trackColor,
    this.thumbHeight,
    this.thumbWidth,
    this.overlayColor,
    this.thumbDecoration,
    this.mouseCursor,
  });

  /// The width of the track.
  final double? trackWidth;

  /// The color of the track.
  final Color? trackColor;

  /// The height of the thumb.
  final double? thumbHeight;

  /// The width of the thumb.
  final double? thumbWidth;

  /// The color of the overlay.
  final Color? overlayColor;

  /// The decoration of the thumb.
  final BoxDecoration? thumbDecoration;

  /// {@macro flutter.material.slider.mouseCursor}
  ///
  /// If specified, overrides the default value of [Slider.mouseCursor].
  final MaterialStateProperty<MouseCursor?>? mouseCursor;

  /// Returns the closest [BeforeAfterTheme] instance given the [context].
  static BeforeAfterTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<BeforeAfterTheme>();
    return theme ?? const BeforeAfterTheme();
  }

  @override
  ThemeExtension<BeforeAfterTheme> copyWith({
    double? trackWidth,
    Color? trackColor,
    double? thumbHeight,
    double? thumbWidth,
    Color? overlayColor,
    BoxDecoration? thumbDecoration,
    MaterialStateProperty<MouseCursor?>? mouseCursor,
  }) {
    return BeforeAfterTheme(
      trackWidth: trackWidth ?? this.trackWidth,
      trackColor: trackColor ?? this.trackColor,
      thumbHeight: thumbHeight ?? this.thumbHeight,
      thumbWidth: thumbWidth ?? this.thumbWidth,
      overlayColor: overlayColor ?? this.overlayColor,
      thumbDecoration: thumbDecoration ?? this.thumbDecoration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
    );
  }

  @override
  ThemeExtension<BeforeAfterTheme> lerp(
    covariant BeforeAfterTheme? other,
    double t,
  ) {
    return BeforeAfterTheme(
      trackWidth: lerpDouble(trackWidth, other?.trackWidth, t),
      trackColor: Color.lerp(trackColor, other?.trackColor, t),
      thumbHeight: lerpDouble(thumbHeight, other?.thumbHeight, t),
      thumbWidth: lerpDouble(thumbWidth, other?.thumbWidth, t),
      overlayColor: Color.lerp(overlayColor, other?.overlayColor, t),
      thumbDecoration: BoxDecoration.lerp(
        thumbDecoration,
        other?.thumbDecoration,
        t,
      ),
      mouseCursor: t < 0.5 ? mouseCursor : other?.mouseCursor,
    );
  }

  @override
  int get hashCode =>
      trackWidth.hashCode ^
      trackColor.hashCode ^
      thumbHeight.hashCode ^
      thumbWidth.hashCode ^
      overlayColor.hashCode ^
      thumbDecoration.hashCode ^
      mouseCursor.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BeforeAfterTheme &&
          runtimeType == other.runtimeType &&
          trackWidth == other.trackWidth &&
          trackColor == other.trackColor &&
          thumbHeight == other.thumbHeight &&
          thumbWidth == other.thumbWidth &&
          overlayColor == other.overlayColor &&
          thumbDecoration == other.thumbDecoration &&
          mouseCursor == other.mouseCursor;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('trackWidth', trackWidth));
    properties.add(ColorProperty('trackColor', trackColor));
    properties.add(DoubleProperty('thumbHeight', thumbHeight));
    properties.add(DoubleProperty('thumbWidth', thumbWidth));
    properties.add(ColorProperty('overlayColor', overlayColor));
    properties.add(
      DiagnosticsProperty<BoxDecoration>('thumbDecoration', thumbDecoration),
    );
    properties.add(DiagnosticsProperty<MaterialStateProperty<MouseCursor?>>(
        'mouseCursor', mouseCursor));
  }
}
