import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:path_provider/path_provider.dart';


import '../viewmodels/article_payload.dart';

import 'article_link_item.dart';
import 'article_title.dart';
import 'article_markdown.dart';

class ArticleView extends StatelessWidget {
  final ArticleModel vm;

  ArticleView({
    Key key,
    this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Directory baseDir = Directory("/data/user/0/com.example.neptune/app_flutter/");

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: null,
          title: Text(vm.title),
          floating: true,
          pinned: false,
          expandedHeight: 50.0,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: EdgeInsets.all(5.0),
                child: MarkdownBody(data: vm.mdcontent, imageDirectory: baseDir,),
              ),
            ],
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 20.0,
          delegate: SliverChildListDelegate(
            []..addAll(
                vm.related.map((v) {
                  return GestureDetector(
                    onTap: () {
                      print(v.key);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      child:
                          Text(v.title, style: TextStyle(color: Colors.blue)),
                    ),
                  );
                }),
              ),
          ),
        ),
      ],
      // SliverList(
      //   delegate: SliverChildBuilderDelegate(
      //     (context, index) => Card(
      //       child: Container(
      //         padding: EdgeInsets.all(10.0),
      //         child: new Row()),)

      //   ),)
      // ..add(ArticleTitle(
      //   title: vm.title,
      //   byline: vm.byline,
      //   date: vm.date,
      // ))
      // ..add(ArticleMarkdown(mdcontent: vm.mdcontent))
      // ..addAll(vm.related.map((v) {
      //   return ArticleLinkItem(url: v.key, titleTxt: v.title);
      // })),
    );
  }
}
