import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  final int number;
  
  TestPage({
    Key key,
    this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Test Page $number"),
      ),
    );
  }
}