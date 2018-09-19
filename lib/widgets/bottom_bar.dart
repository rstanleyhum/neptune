import 'package:flutter/material.dart';

import '../constants.dart' as globals;
import '../providers/ui_provider.dart';

import 'news_tab.dart';
import 'handbook_tab.dart';
import 'pharma_tab.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final uiBloc = UIProvider.of(context);
    return StreamBuilder<int>(
      stream: uiBloc.tabIndex,
      initialData: globals.initialTabIndex,
      builder: (context, snapshot) {
        return BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            NewsTab(),
            HandbookTab(),
            PharmaTab(),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: snapshot.data,
          onTap: (index) {
            uiBloc.setTabIndex.add(index);
          },
        );
      },
    );
  }
}
