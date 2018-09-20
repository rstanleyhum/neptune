import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:path_provider/path_provider.dart';

class ArticleMarkdown extends StatelessWidget {
  final String mdcontent;

  ArticleMarkdown({
    this.mdcontent,
  });

  @override
  Widget build(BuildContext context) {
    Directory baseDir = Directory("/data/user/0/com.example.neptune/app_flutter/");
  

    if (mdcontent == null || mdcontent.trim() == "") {
      return Container();
    }
    
    return ListTile(
      title: MarkdownBody(
        data: "mdcontent",
        imageDirectory: baseDir,
      ),
    );
  }
}
