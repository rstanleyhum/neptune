import 'package:flutter/material.dart';

import '../constants.dart' as globals;

class AppDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
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
    );
  }
}
