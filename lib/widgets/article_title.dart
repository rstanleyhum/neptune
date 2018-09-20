import 'package:flutter/material.dart';

class ArticleTitle extends StatelessWidget {
  final String title;
  final String byline;
  final String date;

  ArticleTitle({
    this.title,
    this.byline,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(" $byline\n updated: $date"),
    );
  }
}
