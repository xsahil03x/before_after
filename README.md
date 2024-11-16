# 👏 Before After [![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://opensource.org/licenses/MIT) [![License](https://img.shields.io/badge/license-MIT-orange.svg)](https://github.com/xsahil03x/before_after/blob/master/LICENSE) [![before_after](https://github.com/xsahil03x/before_after/actions/workflows/before_after.yaml/badge.svg)](https://github.com/xsahil03x/before_after/actions/workflows/before_after.yaml) [![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-blue.svg)](https://github.com/Solido/awesome-flutter) [![FlutterWeekly](https://img.shields.io/badge/Flutter%20Weekly-%2368-teal.svg)](https://mailchi.mp/flutterweekly/flutter-weekly-68)

<p align="center"> 
<img src="https://user-images.githubusercontent.com/25670178/61337576-978f1780-a853-11e9-9249-3637d0861ebb.gif" width="100%">
</p>

[![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/xsahil03x) [![Twitter](https://img.shields.io/twitter/url/https/github.com/xsahil03x/giffy_dialog.svg?style=social)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fxsahil03x%2Fgiffy_dialog)

<p>A flutter package which makes it easier to display the differences between two images..</p>

The source code is **100% Dart**, and everything resides in
the [/lib](https://github.com/xsahil03x/giffy_dialog/tree/master/lib) folder.

Live Demo: https://xsahil03x.github.io/before_after

### Show some :heart: and star the repo to support the project

[![GitHub stars](https://img.shields.io/github/stars/xsahil03x/before_after.svg?style=social&label=Star)](https://github.com/xsahil03x/before_after) [![GitHub forks](https://img.shields.io/github/forks/xsahil03x/before_after.svg?style=social&label=Fork)](https://github.com/xsahil03x/before_after/fork) [![GitHub watchers](https://img.shields.io/github/watchers/xsahil03x/before_after.svg?style=social&label=Watch)](https://github.com/xsahil03x/before_after) [![GitHub followers](https://img.shields.io/github/followers/xsahil03x.svg?style=social&label=Follow)](https://github.com/xsahil03x/giffy_dialog)  
[![Twitter Follow](https://img.shields.io/twitter/follow/xsahil03x.svg?style=social)](https://twitter.com/xsahil03x)

# 🔅 Gifs

|                                                                                                                                                 |                                                                                                                                                 |                                                                                                                                                 |
|-------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| <img src="https://user-images.githubusercontent.com/25670178/61337857-a3c7a480-a854-11e9-9582-87d7f5592007.gif" height="400" alt="Screenshot"/> | <img src="https://user-images.githubusercontent.com/25670178/61338133-ba223000-a855-11e9-8b0a-a236a068c4c2.gif" height="400" alt="Screenshot"/> | <img src="https://user-images.githubusercontent.com/25670178/61338086-8e9f4580-a855-11e9-8b7e-72244b6a456e.gif" height="400" alt="Screenshot"/> |
|                                                                                                                                                 |                                                                                                                                                 |                                                                                                                                                 |

# 💻 Installation

In the `dependencies:` section of your `pubspec.yaml`, add the following line:

[![Version](https://img.shields.io/pub/v/before_after.svg)](https://pub.dartlang.org/packages/before_after)

```yaml
dependencies:
  before_after: <latest version>
```

# ❔ Usage

### Import this class

```dart
import 'package:before_after/before_after.dart';
```

### before after

```dart
BeforeAfter(
  value: value,
  before: Image.asset('assets/after.png'),
  after: Image.asset('assets/before.png'),
  onValueChanged: (value) {
    setState(() => this.value = value);
  },
)
```

## 🎨 Customization and Attributes

| Field                  | Type                           | Description                                                                             |
|------------------------|--------------------------------|-----------------------------------------------------------------------------------------|
| before                 | Widget                         | The widget to be displayed before the slider.                                           |
| after                  | Widget                         | The widget to be displayed after the slider.                                            |
| direction              | SliderDirection                | The drag direction of the slider.                                                       |
| height                 | double?                        | The height of the BeforeAfter widget.                                                   |
| width                  | double?                        | The width of the BeforeAfter widget.                                                    |
| trackWidth             | double?                        | The width of the slider track.                                                          |
| trackColor             | Color?                         | The color of the slider track.                                                          |
| hideThumb              | bool                           | Whether to hide the slider thumb.                                                       |
| thumbHeight            | double?                        | The height of the slider thumb.                                                         |
| thumbWidth             | double?                        | The width of the slider thumb.                                                          |
| thumbColor             | Color?                         | The color of the slider thumb.                                                          |
| overlayColor           | MaterialStateProperty<Color?>? | The highlight color that's typically used to indicate that the slider thumb is focused. |
| thumbDecoration        | BoxDecoration?                 | The decoration of the slider thumb.                                                     |
| divisions              | int?                           | The number of discrete divisions on the slider.                                         |
| value                  | double                         | The position of the slider, ranging from 0.0 to 1.0.                                    |
| onValueChanged         | ValueChanged<double>?          | A callback function that is called when the value of the slider changes.                |
| thumbDivisions         | int?                           | The number of discrete divisions on the slider thumb.                                   |
| thumbPosition          | double                         | The position of the slider thumb, ranging from 0.0 to 1.0.                              |
| onThumbPositionChanged | ValueChanged<double>?          | A callback function that is called when the position of the thumb changes.              |
| focusNode              | FocusNode?                     | The focus node for the widget.                                                          |
| autofocus              | bool                           | Whether the widget should be focused automatically.                                     |
| mouseCursor            | MouseCursor?                   | The cursor for a mouse pointer when it enters or hovers over the widget.                |

# 📃 License

[MIT License](LICENSE)
