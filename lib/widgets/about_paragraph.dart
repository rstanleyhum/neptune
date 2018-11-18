import 'package:flutter/material.dart';

class AboutParagraph extends Container {
  final String text;

  AboutParagraph({
    Key key,
    this.text,
  }) : super(
          key: key,
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 0.0,
            bottom: 10.0,
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 16.0),
          ),
        );
}
