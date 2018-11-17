import 'dart:async';

import 'package:flutter/material.dart';

import '../viewmodels/article_payload.dart';

import 'view_section.dart';
import 'article_view.dart';

class SectionControl extends StatefulWidget {
  final Stream<ArticlePayloadModel> inStream;
  final Sink<String> sendUpdate;
  final String tabPrefix;

  SectionControl({
    Key key,
    this.inStream,
    this.sendUpdate,
    this.tabPrefix,
  }) : super(key: key);

  @override
  _SectionControlState createState() => _SectionControlState();
}

class _SectionControlState extends State<SectionControl>
    with TickerProviderStateMixin {
  TabController controller;
  List<Widget> pages;
  String oldPayloadKey = "";

  List<Widget> _createPages(ArticlePayloadModel payload, String prefix) {
    return payload.articles.map((v) {
      return ArticleView(
          key: PageStorageKey("$prefix: article: ${v.key}"), vm: v);
    }).toList();
  }

  TabController _createController(ArticlePayloadModel payload) {
    return TabController(
      length: payload.articles.length,
      vsync: this,
      initialIndex: payload.index,
    );
  }

  Widget createStreamBuilderWidget(
    Stream<ArticlePayloadModel> inStream,
    Sink<String> sendUpdate,
    String prefix,
  ) {
    return StreamBuilder<ArticlePayloadModel>(
      stream: inStream,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot == null || !snapshot.hasData) {
          return Container();
        }
        var payload = snapshot.data;
        var keyString = payload.articles[payload.index].key;

        if (keyString != oldPayloadKey) {
          pages = _createPages(payload, prefix);
          controller = _createController(payload);
          controller.addListener(() {
            sendUpdate.add(payload.articles[controller.index].key);
          });
          controller.animateTo(payload.index);
        }

        return ViewSection(
          key: Key("$prefix: $keyString"),
          pages: pages,
          controller: controller,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return createStreamBuilderWidget(
      widget.inStream,
      widget.sendUpdate,
      widget.tabPrefix,
    );
  }
}
