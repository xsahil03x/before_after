# 👏 Before After [![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://opensource.org/licenses/MIT) [![License](https://img.shields.io/badge/license-MIT-orange.svg)](https://github.com/xsahil03x/before_after/blob/master/LICENSE) [![Build Status](https://travis-ci.com/xsahil03x/before_after.svg?branch=master)](https://travis-ci.com/xsahil03x/before_after) [![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-blue.svg)](https://github.com/Solido/awesome-flutter) [![FlutterWeekly](https://img.shields.io/badge/Flutter%20Weekly-%2368-teal.svg)](https://mailchi.mp/flutterweekly/flutter-weekly-68)

<p align="center"> 
<img src="https://user-images.githubusercontent.com/25670178/61337576-978f1780-a853-11e9-9249-3637d0861ebb.gif" width="100%">
</p>

[![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/xsahil03x) [![Twitter](https://img.shields.io/twitter/url/https/github.com/xsahil03x/giffy_dialog.svg?style=social)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fxsahil03x%2Fgiffy_dialog)

<p>A flutter package which makes it easier to display the differences between two images..</p>

The source code is **100% Dart**, and everything resides in the [/lib](https://github.com/xsahil03x/giffy_dialog/tree/master/lib) folder.


### Show some :heart: and star the repo to support the project

[![GitHub stars](https://img.shields.io/github/stars/xsahil03x/before_after.svg?style=social&label=Star)](https://github.com/xsahil03x/before_after) [![GitHub forks](https://img.shields.io/github/forks/xsahil03x/before_after.svg?style=social&label=Fork)](https://github.com/xsahil03x/before_after/fork) [![GitHub watchers](https://img.shields.io/github/watchers/xsahil03x/before_after.svg?style=social&label=Watch)](https://github.com/xsahil03x/before_after) [![GitHub followers](https://img.shields.io/github/followers/xsahil03x.svg?style=social&label=Follow)](https://github.com/xsahil03x/giffy_dialog)  
[![Twitter Follow](https://img.shields.io/twitter/follow/xsahil03x.svg?style=social)](https://twitter.com/xsahil03x)

# 🔅 Gifs

| | |  |
| ------------------ | ------------------ | ------------------ |
| <img src="https://user-images.githubusercontent.com/25670178/61337857-a3c7a480-a854-11e9-9582-87d7f5592007.gif" height="400" alt="Screenshot"/>  | <img src="https://user-images.githubusercontent.com/25670178/61338133-ba223000-a855-11e9-8b0a-a236a068c4c2.gif" height="400" alt="Screenshot"/>  | <img src="https://user-images.githubusercontent.com/25670178/61338086-8e9f4580-a855-11e9-8b7e-72244b6a456e.gif" height="400" alt="Screenshot"/>  |
| | |  |

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
     beforeImage: Image.asset('assets/after.jpg'),
     afterImage: Image.asset('assets/before.jpg'),
   ),
```

## 🎨 Customization and Attributes

All customizable attributes for BeforeAfter Widget
<table>
    <th>Attribute Name</th>
    <th>Example Value</th>
    <th>Description</th>
    <tr>
        <td>beforeImage (Widget)</td>
        <td>Image.asset('assets/before.jpg')</td>
        <td>Sets the Before Image</td>
    </tr>
    <tr>
        <td>afterImage (Widget)</td>
        <td>Image.asset('assets/after.jpg')</td>
        <td>Sets the After Image</td>
    </tr>
    <tr>
            <td>isVertical (bool)</td>
            <td>false</td>
            <td>Sets the orientation of the slider</td>
        </tr>
    <tr>
        <td>imageHeight (double)</td>
        <td>100.0</td>
        <td>Sets height of both the images</td>
    </tr>
    <tr>
        <td>imageWidth (double)</td>
        <td>200.0</td>
        <td>Sets width of the images</td>
    </tr>
    <tr>
        <td>imageCornerRadius (double)</td>
        <td>16.0</td>
        <td>Sets the corner radius of the images</td>
    </tr>
    <tr>
        <td>thumbColor (Color)</td>
        <td>Colors.red</td>
        <td>Sets the color of the slider</td>
    </tr>
      <tr>
        <td>thumbRadius (double)</td>
        <td>16.0</td>
        <td>Sets the radius of the thumb circle</td>
    </tr>
      <tr>
        <td>overlayColor (Color)</td>
        <td>Colors.yellow</td>
        <td>Sets the color of the slider thumb overlay</td>
    </tr>
    
</table>

# 👍 How to Contribute
1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

# 📃 License

    Copyright (c) 2019 Sahil Kumar
    
    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).
