import 'package:flutter/material.dart';

import '../viewmodels/drawer_vm.dart';
import '../providers/app_provider.dart';

import 'app_drawer_header.dart';

class ViewSectionDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBloc = AppProvider.of(context);

    return StreamBuilder<DrawerVM>(
      stream: appBloc.drawerVMPayload,
      initialData: null,
      builder: (context, snapshot) {
        var tiles = <Widget>[];

        if (snapshot != null && snapshot.hasData) {
          tiles
            ..add(
              Container(
                padding: EdgeInsets.only(
                    left: 10.0, right: 20.0, top: 10.0, bottom: 5.0),
                child: Text(
                  "Links:",
                  style: TextStyle(
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ),
            );

          if (snapshot.data.parentLink != null) {
            tiles
              ..add(GestureDetector(
                onTap: () {
                  appBloc.sendArticleSelect.add(snapshot.data.parentLink.key);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 20.0, top: 0.0, bottom: 10.0),
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
                        left: 24.0, right: 20.0, top: 0.0, bottom: 12.0),
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
                height: 20.0,
              ),
            );
        }

        return Drawer(
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                AppDrawerHeader(),
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
