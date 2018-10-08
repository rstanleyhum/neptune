import 'package:flutter/material.dart';

import '../constants.dart' as globals;
import '../providers/app_provider.dart';

import 'view_section_drawer.dart';
import 'about_drawer.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBloc = AppProvider.of(context);
    return StreamBuilder<int>(
      stream: appBloc.tabIndex,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot != null &&
            snapshot.hasData &&
            snapshot.data == globals.aboutTabIndex) {
          return AboutDrawer();
        }
        return ViewSectionDrawer();
      },
    );
  }
}
