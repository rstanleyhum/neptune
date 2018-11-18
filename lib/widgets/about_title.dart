import 'package:flutter/material.dart';

class AboutTitle extends Container {
  final String text;

  AboutTitle({
    Key key,
    this.text,
  }) : super(
          key: key,
          alignment: Alignment.center,
          padding:
              EdgeInsets.only(left: 0.0, right: 30.0, top: 20.0, bottom: 10.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
        );
}
