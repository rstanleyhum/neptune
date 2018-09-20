import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../models/article.dart';

class LocalService {
  static const _baseDir = "assets/sensitive";
  static const _indexFile = "files.json";
  static const _imagesFile = "images.json";
  static const _jsonImages = "images";
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

  static Future<void> loadImages() async {
    await _createImagesDirectory();
    try {
      var s = await _loadAsset("$_baseDir/images/$_imagesFile");
      var json = jsonDecode(s);
      var filenames = (json[_jsonImages] as List).cast<String>().toList();
      await Future.wait(filenames.map((n) {
        return _loadAndSaveImage(n, "$_baseDir/images/$n");
      }));
    } catch (e) {
      print(e);
    }
  }

  static Future<void> _loadAndSaveImage(String n, String s) async {
    final directory = await getApplicationDocumentsDirectory();
    var imagesDirPath = "${directory.path}/images/";
    
    ByteData fileData = await rootBundle.load(s);
    Uint8List fileBytes = fileData.buffer.asUint8List();

    var filename = "$imagesDirPath${n.toLowerCase()}";
    File(filename).writeAsBytes(fileBytes.toList())
    .then((File file) {
    }).catchError((e) {
      print(e);
    });
  }

  static Future<void> _createImagesDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    var imagesDirPath = "${directory.path}/images/";
    Directory(imagesDirPath).create(recursive: true)
    .then((Directory directory) {
    }).catchError((e) {
      print(e);
    });
  }

}
