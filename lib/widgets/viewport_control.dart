import 'package:flutter/material.dart';

import '../constants.dart' as globals;

import '../providers/app_provider.dart';

import 'about_section_view.dart';
import 'section_control.dart';

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
                child: SectionControl(
                  key: Key("NewsSectionControl"),
                  inStream: appBloc.newsPayload,
                  sendUpdate: appBloc.sendNewsUpdate,
                  tabPrefix: "news",
                ),
              ),
            ),
            Offstage(
              offstage: snapshot.data != globals.handbookTabIndex,
              child: TickerMode(
                enabled: snapshot.data == globals.handbookTabIndex,
                child: SectionControl(
                  key: Key("HandbookSectionControl"),
                  inStream: appBloc.handbookPayload,
                  sendUpdate: appBloc.sendHandbookUpdate,
                  tabPrefix: "handbook",
                ),
              ),
            ),
            Offstage(
              offstage: snapshot.data != globals.pharmaTabIndex,
              child: TickerMode(
                enabled: snapshot.data == globals.pharmaTabIndex,
                child: SectionControl(
                  key: Key("PharmaSectionControl"),
                  inStream: appBloc.pharmaPayload,
                  sendUpdate: appBloc.sendPharmaUpdate,
                  tabPrefix: "pharma",
                ),
              ),
            ),
            Offstage(
              offstage: snapshot.data != globals.aboutTabIndex,
              child: TickerMode(
                enabled: snapshot.data == globals.aboutTabIndex,
                child: AboutSectionView(),
              ),
            ),
          ],
        );
      },
    );
  }
}
