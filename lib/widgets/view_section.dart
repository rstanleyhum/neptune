import 'package:flutter/material.dart';

class ViewSection extends StatelessWidget {
  final TabController controller;
  final List<Widget> pages;

  ViewSection({
    Key key,
    this.controller,
    this.pages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: pages,
      controller: controller,
    );
  }
}
