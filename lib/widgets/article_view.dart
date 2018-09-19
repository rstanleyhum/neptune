import 'package:flutter/material.dart';

import '../viewmodels/article_payload.dart';

class ArticleView extends StatelessWidget {
  final ArticleModel vm;

  ArticleView({
    Key key,
    this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text(vm.title),
        Text(vm.byline),
        Text(vm.date),
        Text(vm.mdcontent)
      ]
      ..addAll(vm.related.map((v) {
        return Text("${v.key} - ${v.title}");
      })),
    );
  }
}