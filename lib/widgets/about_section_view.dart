import 'package:flutter/material.dart';

import '../constants.dart' as globals;

import 'about_disclaimer_text.dart';
import 'about_contact_us_text.dart';

class AboutSectionView extends StatefulWidget {
  @override
  _AboutSectionViewState createState() => _AboutSectionViewState();
}

class _AboutSectionViewState extends State<AboutSectionView> {
  List<Widget> information;

  @override
  void initState() {
    this.information = AboutDisclaimerText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text(globals.aboutTabTitle),
          floating: true,
          pinned: false,
          primary: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 10.0,
                top: 20.0,
                bottom: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    child: Text(globals.aboutDisclaimerTitle),
                    onPressed: () {
                      setState(() {
                        this.information = AboutDisclaimerText();
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text(globals.aboutLicencesTitle),
                    onPressed: () {
                      showLicensePage(context: context);
                    },
                  ),
                  RaisedButton(
                    child: Text(globals.aboutContactUsTitle),
                    onPressed: () {
                      setState(() {
                        this.information = AboutContactUsText();
                      });
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            information,
          ),
        )
      ],
    );
  }
}
