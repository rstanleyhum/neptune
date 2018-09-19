import 'package:flutter/material.dart';

import '../constants.dart' as globals;

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Center(
        child: Text(
          globals.mainDrawerHeaderTitle,
          style: TextStyle(fontSize: globals.mainDrawerHeaderFontSize),
        ),
      ),
      decoration: BoxDecoration(
        color: globals.themeColor,
      ),
    );
  }
}
