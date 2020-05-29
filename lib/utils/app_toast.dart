import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// toast widget
class AppToast extends StatelessWidget {
  /// message to be displayed
  final String text;

  /// primary constructor
  const AppToast({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 48),
      color: Colors.black,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
