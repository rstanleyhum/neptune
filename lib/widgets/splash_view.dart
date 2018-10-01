import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../constants.dart' as globals;
import '../route_names.dart' as RouteNames;

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool disclaimerState = prefs.getBool(globals.disclaimerStateKey) ?? false;

    if (disclaimerState) {
      Navigator.of(context).pushReplacementNamed(RouteNames.BaseViewRoute);
    } else {
      Navigator.of(context)
          .pushReplacementNamed(RouteNames.DisclaimerViewRoute);
    }
  }

  startTime() async {
    var _duration = Duration(seconds: globals.splashPageDelay);
    return Timer(_duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(globals.splashPageTitle),
      ),
    );
  }
}
