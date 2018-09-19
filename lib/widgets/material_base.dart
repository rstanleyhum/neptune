import 'package:flutter/material.dart';

import '../constants.dart' as globals;

import 'base_view.dart';

class MaterialBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: globals.materialAppTitle,
        theme: ThemeData(
          primarySwatch: globals.themeColor,
        ),
        home: BaseView(),
      );
}
