import 'package:flutter/material.dart';

import '../providers/article_provider.dart';
import '../viewmodels/article_payload.dart';

import 'view_section.dart';
import 'article_view.dart';

class ViewportControl extends StatefulWidget {
  @override
  _ViewportControlState createState() => _ViewportControlState();
}

class _ViewportControlState extends State<ViewportControl>
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final articleBloc = ArticleProvider.of(context);
    return StreamBuilder<ArticlePayloadModel>(
      stream: articleBloc.newsPayload,
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

        return ViewSection(
          pages: _createPages(snapshot.data),
          controller: _createController(snapshot.data),
        );
      },  
    );
  }
}
