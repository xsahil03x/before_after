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
        child: BeforeAfter(
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
