import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../constants.dart' as globals;
import '../route_names.dart' as RouteNames;

class DisclaimerView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(globals.disclaimerTitle),
            RaisedButton(
              child: Text(globals.disclaimerButtonText),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool(globals.disclaimerStateKey, true);
                Navigator.pushReplacementNamed(
                    context, RouteNames.BaseViewRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
