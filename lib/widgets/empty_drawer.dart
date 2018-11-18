import 'package:flutter/material.dart';

import 'app_drawer_header.dart';

class EmptyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tiles = <Widget>[];

    return Drawer(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            AppDrawerHeader(),
            SliverList(
                delegate: SliverChildListDelegate(
              tiles,
            ))
          ],
        ),
      ),
    );
  }
}
