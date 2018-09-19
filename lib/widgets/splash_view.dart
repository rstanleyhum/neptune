import 'dart:async';

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

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(RouteNames.BaseViewRoute);
  }

  startTime() async {
    var _duration = Duration(seconds: 2);
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
