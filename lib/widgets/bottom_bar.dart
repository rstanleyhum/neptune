import 'package:flutter/material.dart';

import '../constants.dart' as globals;
import '../providers/app_provider.dart';

import 'news_tab.dart';
import 'handbook_tab.dart';
import 'pharma_tab.dart';
import 'about_tab.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final appBloc = AppProvider.of(context);
    return StreamBuilder<int>(
      stream: appBloc.tabIndex,
      initialData: globals.initialTabIndex,
      builder: (context, snapshot) {
        return BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            NewsTab(),
            HandbookTab(),
            PharmaTab(),
            AboutTab(),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: snapshot.data,
          onTap: (index) {
            appBloc.setTabIndex.add(index);
          },
        );
      },
    );
  }
}
