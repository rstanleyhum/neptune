import 'package:flutter/material.dart';

import '../constants.dart' as globals;
import '../route_names.dart' as routeNames;

import 'base_view.dart';
import 'splash_view.dart';
import 'disclaimer_view.dart';

class MaterialBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: globals.materialAppTitle,
        theme: ThemeData(
          primarySwatch: globals.themeColor,
        ),
        home: SplashView(),
        routes: <String, WidgetBuilder>{
          routeNames.DisclaimerViewRoute: (context) => DisclaimerView(),
          routeNames.BaseViewRoute: (context) => BaseView(),
        },
      );
}
