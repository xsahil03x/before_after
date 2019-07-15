import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Before After')),
      body: Center(
        child: CustomWidget(
          imageHeight: size.height / 2,
          imageWidth: size.width,
          beforeImage: Image.asset(
            'assets/after.jpg',
            fit: BoxFit.cover,
          ),
          afterImage: Image.asset(
            'assets/before.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

/*class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _width = 0.5;
  double _height = 0.5;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Container(
        color: Colors.red,
        child: Center(
          child: Container(
            width: size.width / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset('assets/after.jpg'),
                    ClipRect(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        widthFactor: _width,
                        child: Image.asset(
                          'assets/before.jpg',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      bottom: 0.0,
                      right: 0.0,
                      left: 0.0,
                      child: SliderTheme(
                        data: SliderThemeData(thumbShape: CustomThumb(16.0)),
                        child: Slider(
                          onChanged: (double val) =>
                              setState(() => this._width = val),
                          value: _width,
                          min: 0.0,
                          max: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Stack(
                  children: <Widget>[
                    Image.asset('assets/after.jpg'),
                    ClipRect(
                      child: Align(
                        alignment: Alignment.topLeft,
                        heightFactor: _height,
                        child: Image.asset('assets/before.jpg'),
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      bottom: 0.0,
                      right: 0.0,
                      left: 0.0,
                      child: Transform.rotate(
                        angle: math.pi / 2,
                        child: Slider(
                          onChanged: (double val) =>
                              setState(() => this._height = val),
                          value: _height,
                          min: 0.0,
                          max: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/

class CustomThumb extends SliderComponentShape {
  final double _thumbRadius;

  CustomThumb(this._thumbRadius);

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

    final rect = Rect.fromCircle(center: center, radius: _thumbRadius);

    final rrect = RRect.fromRectAndRadius(
      Rect.fromPoints(
        Offset(rect.left, rect.top),
        Offset(rect.right, rect.bottom),
      ),
      Radius.circular(_thumbRadius),
    );

    final fillPaint = Paint()
      ..color = sliderTheme.activeTrackColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.8
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(rrect, fillPaint);
    canvas.drawRRect(rrect, borderPaint);
  }
}
