import 'package:flutter/material.dart';

class AboutSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text("About"),
          floating: true,
          pinned: false,
          primary: true,
        ),
      ],
    );
  }
}
