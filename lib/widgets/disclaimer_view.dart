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
            Text(globals.disclaimerButtonText),
            RaisedButton(
              child: Text(globals.disclaimerTitle),
              onPressed: () {
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
