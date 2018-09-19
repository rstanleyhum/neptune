import 'package:flutter/material.dart';

import 'view_section.dart';
import 'test_page.dart';

class ViewportControl extends StatefulWidget {
  @override
  _ViewportControlState createState() => _ViewportControlState();
}

class _ViewportControlState extends State<ViewportControl>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  List<Widget> _createPages() {
    return []
      ..add(TestPage(number: 1))
      ..add(TestPage(number: 2))
      ..add(TestPage(number: 3));
  }
  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewSection(
      pages: _createPages(),
      controller: _controller,
    );
  }
}
