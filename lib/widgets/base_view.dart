import 'package:flutter/material.dart';

import 'viewport_control.dart';
import 'bottom_bar.dart';
import 'app_drawer.dart';

class BaseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ViewportControl(),
      ),
      bottomNavigationBar: BottomBar(),
      drawer: AppDrawer(),
    );
  }
}
