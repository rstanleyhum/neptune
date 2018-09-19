import 'package:flutter/material.dart';

import '../constants.dart' as globals;

class PharmaTab extends BottomNavigationBarItem {
  PharmaTab()
      : super(
          title: Text(globals.pharmaTabTitle),
          icon: Icon(globals.pharmaIcon),
        );
}
