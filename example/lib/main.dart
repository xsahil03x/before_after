import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Before After'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: BeforeAfter(
                beforeImage: Image.asset('assets/after.jpg'),
                afterImage: Image.asset('assets/before.jpg'),
              ),
            ),
            Expanded(
              flex: 1,
              child: BeforeAfter(
                beforeImage: Image.asset('assets/after.jpg'),
                afterImage: Image.asset('assets/before.jpg'),
                isVertical: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
