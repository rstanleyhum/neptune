import 'dart:async';

import 'package:flutter/material.dart';

import '../providers/app_provider.dart';
import '../viewmodels/article_payload.dart';

import 'view_section.dart';
import 'article_view.dart';

class NewsSectionControl extends StatefulWidget {
  @override
  _NewsSectionControlState createState() => _NewsSectionControlState();
}

class _NewsSectionControlState extends State<NewsSectionControl>
    with TickerProviderStateMixin {
  
  List<Widget> _createPages(ArticlePayloadModel payload) {
    return payload.articles.map( (v) {
      return ArticleView(key: PageStorageKey("news: article: ${v.key}"), vm: v);
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
          return Container();
        }
        var payload = snapshot.data;

        var pages = _createPages(payload);
        var controller = _createController(payload);
        controller.animateTo(payload.index);
        var keyString = payload.articles[payload.index].key;

        return ViewSection(
          key: Key("news: $keyString"),
          pages: pages,
          controller: controller,
        );
      },  
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBloc = AppProvider.of(context);
    return createStreamBuilderWidget(appBloc.newsPayload);
  }
}
