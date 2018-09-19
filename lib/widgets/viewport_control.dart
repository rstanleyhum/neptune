import 'package:flutter/material.dart';

import '../constants.dart' as globals;

import '../providers/ui_provider.dart';

import 'news_section_control.dart';
import 'handbook_section_control.dart';
import 'pharma_section_control.dart';

class ViewportControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiBloc = UIProvider.of(context);
    return StreamBuilder<int>(
      stream: uiBloc.tabIndex,
      initialData: globals.initialTabIndex,
      builder: (context, snapshot) {
        return <Widget>[
          NewsSectionControl(),
          HandbookSectionControl(),
          PharmaSectionControl(),
        ][snapshot.data];
      },
    );
  }
}