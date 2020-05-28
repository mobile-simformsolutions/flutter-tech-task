import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Task Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(), // TODO: implement UI
    );
  }
}
