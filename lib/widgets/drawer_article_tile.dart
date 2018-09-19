import 'package:flutter/material.dart';

class DrawerArticleTile extends StatelessWidget {
  final String tileText;

  DrawerArticleTile({
    Key key,
    this.tileText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tileText)
    );
  }
}