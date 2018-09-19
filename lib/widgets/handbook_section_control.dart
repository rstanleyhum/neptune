import 'dart:async';

import 'package:flutter/material.dart';

import '../providers/article_provider.dart';
import '../viewmodels/article_payload.dart';

import 'view_section.dart';
import 'article_view.dart';

class HandbookSectionControl extends StatefulWidget {
  @override
  _HandbookSectionControlState createState() => _HandbookSectionControlState();
}

class _HandbookSectionControlState extends State<HandbookSectionControl>
    with SingleTickerProviderStateMixin {
  
  List<Widget> _createPages(ArticlePayloadModel payload) {
    return payload.articles.map( (v) {
      return ArticleView(vm: v);
    }).toList();
  }

  TabController _createController(ArticlePayloadModel payload) {
    return TabController(
      length: payload.articles.length,
      vsync: this,
      initialIndex: payload.index,
    );
  }

  Widget createStreamBuilderWidget(Stream<ArticlePayloadModel> inStream) {
    return StreamBuilder<ArticlePayloadModel>(
      stream: inStream,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot == null || !snapshot.hasData) {
          return ViewSection(
            pages: <Widget>[
              Container(),
            ],
            controller: TabController(
              length: 1,
              vsync: this,
              initialIndex: 0,
            ),
          );
        }

        var pages = _createPages(snapshot.data);
        var controller = _createController(snapshot.data);
        return ViewSection(
          pages: pages,
          controller: controller,
        );
      },  
    );
  }

  @override
  Widget build(BuildContext context) {
    final articleBloc = ArticleProvider.of(context);
    return createStreamBuilderWidget(articleBloc.handbookPayload);
  }
}
