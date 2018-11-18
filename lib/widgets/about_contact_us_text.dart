import 'package:flutter/material.dart';

import '../constants.dart' as globals;

import 'about_paragraph.dart';
import 'about_title.dart';

List<Widget> AboutContactUsText() {
  return <Widget>[
    AboutTitle(
      text: globals.aboutContactUsTitle,
    ),
    AboutParagraph(
      text: globals.contactUsPageParagraph1,
    ),
    AboutParagraph(
      text: globals.contactUsPageParagraph2,
    ),
    AboutParagraph(
      text: globals.contactUsPageParagraph3,
    ),
  ];
}
