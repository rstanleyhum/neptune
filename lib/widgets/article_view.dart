import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../providers/app_provider.dart';
import '../viewmodels/article_payload.dart';

class ArticleView extends StatelessWidget {
  final ArticleModel vm;

  ArticleView({
    Key key,
    this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Directory baseDir =
        Directory("/data/user/0/com.example.neptune/app_flutter/");
    final appBloc = AppProvider.of(context);

    return CustomScrollView(
      slivers: <Widget>[
        // AppBar with Title
        SliverAppBar(
          title: Text(vm.title),
          floating: true,
          pinned: false,
          primary: true,
        ),

        // MarkdownBody and ByLine
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: EdgeInsets.only(left: 15.0, right: 10.0, top: 5.0, bottom: 10.0),
                child: Text("by: ${vm.byline} (updated: ${vm.date})", style: TextStyle(color: Colors.grey)),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                child: MarkdownBody(
                  data: vm.mdcontent,
                  imageDirectory: baseDir,
                ),
              ),
            ],
          ),
        ),

        // Related List Links
        SliverFixedExtentList(
          itemExtent: 20.0,
          delegate: SliverChildListDelegate(
            []..addAll(
                vm.related.map((v) {
                  return GestureDetector(
                    onTap: () {
                      appBloc.sendArticleSelect.add(v.key);
                      appBloc.setTabIndexByEvent.add(v.key);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                      child:
                          Text(v.title, style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                    ),
                  );
                }),
              ),
          ),
        ),
      ],
    );
  }
}
