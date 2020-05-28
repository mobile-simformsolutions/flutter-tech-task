import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// Entry widget of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Task Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'GTWalsheim',
      ),
      home: Container(), // TODO: implement UI
    );
  }
}
