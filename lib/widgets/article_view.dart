import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../providers/app_provider.dart';
import '../viewmodels/article_payload.dart';

import 'image_viewer.dart';

class ArticleView extends StatelessWidget {
  final ArticleModel vm;

  ArticleView({
    Key key,
    this.vm,
  }) : super(key: key);

  void _handleTapLink(BuildContext context, String url, Directory baseDir) {
    var parts = url.split("://");
    if (parts.length != 2) {
      return;
    }

    var prefix = parts[0];
    if (prefix != "hybrid-image") {
      return;
    }

    var fn = parts[1];
    String filepath = "${baseDir.path}/$fn";
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ImageViewer(
            filepath: filepath,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBloc = AppProvider.of(context);
    Directory baseDir = appBloc.baseAppDirectory;

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
                padding: EdgeInsets.only(
                    left: 15.0, right: 10.0, top: 5.0, bottom: 10.0),
                child: Text("by: ${vm.byline} (updated: ${vm.date})",
                    style: TextStyle(color: Colors.grey)),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                child: MarkdownBody(
                  data: vm.mdcontent,
                  onTapLink: (url) => _handleTapLink(context, url, baseDir),
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
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                      child: Text(v.title,
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline)),
                    ),
                  );
                }),
              ),
          ),
        ),

        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                height: 30.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
