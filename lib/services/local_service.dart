import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/article.dart';


class LocalService {
  static const _baseDir = "assets/sensitive";
  static const _indexFile = "files.json";
  static const _jsonIndex = "filenames";
  
  static Future<String> _loadAsset(String filename) async {
    return await rootBundle.loadString(filename);
  }

  static Future<List<Article>> loadArticles() async {
    List<Article> articles = new List<Article>();
    try {
      var s = await _loadAsset("$_baseDir/$_indexFile");
      var json = jsonDecode(s);
      var filenames = (json[_jsonIndex] as List).cast<String>().toList();
      var articlesContent = await Future.wait(filenames.map((n) {
        return _loadAsset("$_baseDir/$n");
      }));

      for (var i = 0; i < filenames.length; i++) {
        articles.add(Article.fromContents(filenames[i], articlesContent[i]));
      }
    } catch (e) {
      print(e);
    }

    return articles;
  }
}
