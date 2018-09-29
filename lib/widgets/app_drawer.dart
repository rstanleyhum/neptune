import 'package:flutter/material.dart';

import '../constants.dart' as globals;

import '../providers/app_provider.dart';

import '../viewmodels/drawer_vm.dart';


class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBloc = AppProvider.of(context);
    return StreamBuilder<DrawerVM>(
      stream: appBloc.drawerVMPayload,
      initialData: null,
      builder: (context, snapshot) {
        var tiles = <Widget>[];

        if (snapshot != null && snapshot.hasData) {
          if (snapshot.data.parentLink != null) {
            tiles
              ..add(GestureDetector(
                onTap: () {
                  appBloc.sendArticleSelect.add(snapshot.data.parentLink.key);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 20.0, top: 10.0, bottom: 0.0),
                  child: Text(
                    snapshot.data.parentLink.title,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                ),
              ));
          }

          tiles
            ..addAll(
              snapshot.data.articleLinks.map((v) {
                return GestureDetector(
                  onTap: () {
                    appBloc.sendArticleSelect.add(v.key);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0, bottom: 0.0),
                    child: Text(
                      v.title,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                );
              }).toList(),
            );

          tiles
            ..add(
              Container(
                height: 30.0,
              ),
            );
        }

        return Drawer(
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        height: 150.0,
                        color: Theme.of(context).accentColor,
                        child: Center(
                          child: Text(
                            globals.mainDrawerHeaderTitle,
                            style: TextStyle(
                              fontSize: globals.mainDrawerHeaderFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate(
                  tiles,
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
