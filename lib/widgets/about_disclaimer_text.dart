import 'package:flutter/material.dart';

import '../constants.dart' as globals;

import 'about_paragraph.dart';
import 'about_title.dart';

List<Widget> aboutDisclaimerText() {
  return <Widget>[
    AboutTitle(
      text: globals.aboutDisclaimerTitle,
    ),
    AboutParagraph(
      text: globals.disclaimerPageParagraph1,
    ),
    AboutParagraph(
      text: globals.disclaimerPageParagraph2,
    ),
    AboutParagraph(
      text: globals.disclaimerPageParagraph4,
    ),
  ];
}
