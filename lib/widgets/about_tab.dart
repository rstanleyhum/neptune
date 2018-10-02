import 'package:flutter/material.dart';

import '../constants.dart' as globals;

class AboutTab extends BottomNavigationBarItem {
  AboutTab()
      : super(
          title: Text(globals.aboutTabTitle),
          icon: Icon(globals.aboutIcon),
        );
}
