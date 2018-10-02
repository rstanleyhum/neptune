import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../constants.dart' as globals;
import '../route_names.dart' as RouteNames;

class DisclaimerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  left: 0.0, right: 30.0, top: 30.0, bottom: 10.0),
              child: Text("Disclaimer",
                  style:
                      TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
              child: Text(
                "This is an educational app. It has guidelines and protocols meant as an aide for trainees at our hospital.",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
              child: Text(
                "It is not expansive nor complete. It should not be used without the guidance of qualified healthcare professionals and does not replace clinical judgement.",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 0.0, bottom: 10.0),
              child: Text(
                "By pressing the button below and continuing to use this app, you acknowlege that you understand the limitations of the app and the educational nature of its contents.",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
              child: RaisedButton(
                child: Text(globals.disclaimerButtonText),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool(globals.disclaimerStateKey, true);
                  Navigator.pushReplacementNamed(
                      context, RouteNames.BaseViewRoute);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
