import 'package:flutter/material.dart';

import '../providers/app_provider.dart';
import '../constants.dart' as globals;

import 'viewport_control.dart';
import 'bottom_bar.dart';
import 'app_drawer.dart';

class BaseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBloc = AppProvider.of(context);
    return StreamBuilder<int>(
      stream: appBloc.tabIndex,
      initialData: null,
      builder: (context, snapshot) {
        var isAboutTab = snapshot != null &&
            snapshot.hasData &&
            snapshot.data == globals.aboutTabIndex;
        return Scaffold(
          body: SafeArea(
            child: ViewportControl(),
          ),
          bottomNavigationBar: BottomBar(),
          drawer: isAboutTab ? null : AppDrawer(),
        );
      },
    );
  }
}
