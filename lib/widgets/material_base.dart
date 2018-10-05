import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart' as globals;
import '../route_names.dart' as routeNames;

import 'base_view.dart';
import 'disclaimer_view.dart';

class MaterialBase extends StatefulWidget {
  @override
  _MaterialBaseState createState() => _MaterialBaseState();
}

class _MaterialBaseState extends State<MaterialBase> {
  bool disclaimerState;

  @override
  void initState() {
    super.initState();
    disclaimerState = false;
    _getDisclaimerState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: globals.materialAppTitle,
      theme: ThemeData(
        primarySwatch: globals.themeColor,
      ),
      home: (disclaimerState == null)
          ? DisclaimerView()
          : (disclaimerState) ? BaseView() : DisclaimerView(),
      routes: <String, WidgetBuilder>{
        routeNames.DisclaimerViewRoute: (context) => DisclaimerView(),
        routeNames.BaseViewRoute: (context) => BaseView(),
      },
    );
  }

  void _getDisclaimerState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      disclaimerState = prefs.getBool(globals.disclaimerStateKey) ?? false;
    });
  }
}
