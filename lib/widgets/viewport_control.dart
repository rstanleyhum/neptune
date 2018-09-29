import 'package:flutter/material.dart';

import '../constants.dart' as globals;

import '../providers/app_provider.dart';

import 'news_section_control.dart';
import 'handbook_section_control.dart';
import 'pharma_section_control.dart';

class ViewportControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBloc = AppProvider.of(context);
    return StreamBuilder<int>(
      stream: appBloc.tabIndex,
      initialData: globals.initialTabIndex,
      builder: (context, snapshot) {
        return Stack(
          //
          // Note Offstage starts/stops painting; TickerMode starts/stops animation
          // Keeps everything in the tree so that it doesn't automatically rebuild each
          //  widget
          // See: https://stackoverflow.com/questions/45235570/how-to-use-bottomnavigationbar-with-navigator/45992604#45992604
          //
          children: <Widget>[
            Offstage(
              offstage: snapshot.data != globals.newsTabIndex,
              child: TickerMode(
                enabled: snapshot.data == globals.newsTabIndex,
                child: NewsSectionControl(),
              ),
            ),
            Offstage(
              offstage: snapshot.data != globals.handbookTabIndex,
              child: TickerMode(
                enabled: snapshot.data == globals.handbookTabIndex,
                child: HandbookSectionControl(),
              ),
            ),
            Offstage(
              offstage: snapshot.data != globals.pharmaTabIndex,
              child: TickerMode(
                enabled: snapshot.data == globals.pharmaTabIndex,
                child: PharmaSectionControl(),
              ),
            ),
          ],
        );
      },
    );
  }
}
