import 'package:flutter/material.dart';

import '../constants.dart' as globals;

import 'header.dart';
import 'drawer_article_tile.dart';

class AppDrawer extends StatelessWidget {
  List<Widget> _buildArticleTiles() {
    return []
      ..add(DrawerArticleTile(tileText: globals.drawerItemOne))
      ..add(DrawerArticleTile(tileText: globals.drawerItemTwo));
  }

  List<Widget> _drawerContents() {
    return []
      ..add(Header())
      ..addAll(_buildArticleTiles());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: _drawerContents(),
      ),
    );
  }
}
