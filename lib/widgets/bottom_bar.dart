import 'package:flutter/material.dart';

import '../constants.dart' as globals;

import 'news_tab.dart';
import 'handbook_tab.dart';
import 'pharma_tab.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _index;

  @override
  void initState() {
    super.initState();
    _index = globals.initialTabIndex;
  }

  void _selectIndex(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          NewsTab(),
          HandbookTab(),
          PharmaTab(),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: _selectIndex,
      );
}
