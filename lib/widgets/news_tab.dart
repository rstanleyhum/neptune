import 'package:flutter/material.dart';

import '../constants.dart' as globals;

class NewsTab extends BottomNavigationBarItem {
  NewsTab()
      : super(
          title: Text(globals.newsTabTitle),
          icon: Icon(globals.newsIcon),
        );
}
