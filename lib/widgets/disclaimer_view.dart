import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../constants.dart' as globals;
import '../route_names.dart' as RouteNames;

import 'about_paragraph.dart';
import 'about_title.dart';

class DisclaimerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            AboutTitle(
              text: globals.disclaimerPageTitle,
            ),
            AboutParagraph(
              text: globals.disclaimerPageParagraph1,
            ),
            AboutParagraph(
              text: globals.disclaimerPageParagraph2,
            ),
            AboutParagraph(
              text: globals.disclaimerPageParagraph3,
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
