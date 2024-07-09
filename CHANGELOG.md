## 3.1.0

- Migrated deprecated `MaterialStateProperty` to `WidgetStateProperty`.
- Fixed `widget.thumbColor` not working. [#34](https://github.com/xsahil03x/before_after/issues/34)

## 3.0.0+1

- Add live demo link to README.

## 3.0.0

🚨 Breaking

Changes in the `BeforeAfter` widget:

- Added support for different slider `directions`. The new direction property allows you to specify whether the slider
  can be dragged `horizontally` or `vertically`.
- Renamed the `beforeImage` and `afterImage` properties to `before` and `after`, respectively, for better clarity.
- Added the `height` and `width` properties to control the size of the BeforeAfter widget.
- Added the `trackWidth` property to customize the width of the slider track.
- Added the `trackColor` property to set the color of the slider track.
- Added the `hideThumb` property to hide the slider thumb if needed.
- Added the `thumbHeight` and `thumbWidth` properties to specify the size of the slider thumb.
- Renamed the `thumbColor` property to `thumbDecoration` to allow more flexible customization using BoxDecoration.
- Added the `overlayColor` property to set the color of the overlay when the thumb is interacted.
- Added the `divisions` property to specify the number of discrete divisions on the slider.
- Added the `onValueChanged` callback to handle changes in the slider value.
- Added the `thumbPosition` property to set the initial position of the slider thumb.
- Added the `thumbDivisions` property to specify the number of discrete divisions on the slider thumb.
- Added the `onThumbPositionChanged` callback to handle changes in the thumb position.
- Added support for custom mouse cursors using the `mouseCursor` property.
- Added support for focus and autofocus using the `focusNode` and `autofocus` properties.

New features:

- Added the `BeforeAfterTheme` class to provide default theme values for the BeforeAfter widget.

## 2.1.0

- Added fix for Flutter 1.19.

## 2.0.1

- Minor fixes.

## 2.0.0

- Added support for vertical sliders.

## 1.0.1

- Update Readme.

## 1.0.0

- Initial Release.