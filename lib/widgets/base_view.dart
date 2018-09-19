import 'package:flutter/material.dart';

import 'top_bar.dart';
import 'viewport_control.dart';
import 'bottom_bar.dart';
import 'app_drawer.dart';


class BaseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: ViewportControl(),
      bottomNavigationBar: BottomBar(),
      drawer: AppDrawer(),
    );
  }
}