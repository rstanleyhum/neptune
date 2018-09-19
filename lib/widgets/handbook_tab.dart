import 'package:flutter/material.dart';

import '../constants.dart' as globals;

class HandbookTab extends BottomNavigationBarItem {
  HandbookTab()
      : super(
          title: Text(globals.handbookTabTitle),
          icon: Icon(globals.handbookIcon),
        );
}
