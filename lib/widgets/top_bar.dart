import 'package:flutter/material.dart';

import 'top_bar_title.dart';

class TopBar extends AppBar {
  TopBar()
      : super(
          title: TopBarTitle(),
          centerTitle: true,
        );
}
