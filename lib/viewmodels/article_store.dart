import 'dart:async';

import 'package:intl/intl.dart';

import '../constants.dart' as globals;

import '../models/article.dart';

import 'article_payload.dart';
import 'article_link_model.dart';
import 'drawer_vm.dart';

class ArticleStore {
  Map<String, Article> _allArticles;

  String _newsArticle;
  String _handbookArticle;
  String _pharmaArticle;

  bool _loading;
  bool _loaded;

  ArticleStore() {
    this._allArticles = {};
    this._loading = false;
    this._loaded = false;
    this._newsArticle = null;
    this._handbookArticle = null;
    this._pharmaArticle = null;
  }

  bool get isLoading => _loading;
  bool get isLoaded => _loaded;

  void setLoading() {
    _loading = true;
  }

  void setLoaded() {
    _loaded = true;
    _loading = false;
  }

  static String dateFormatter(DateTime date) {
    return DateFormat(globals.dateFormat).format(date);
  }

  Future<void> addAllArticles(Map<String, Article> articles) {
    return Future(() {
      articles.forEach((k, v) {
        this._allArticles[k] = v;
      });
    });
  }

  Future<void> setAllArticles(Map<String, Article> articles) {
    return Future(() {
      this._allArticles = articles;
    });
  }

  String get newsArticle => _newsArticle;

  Future<void> setNewsArticle(String key) {
    return Future(() {
      this._newsArticle = key;
    });
  }

  String get handbookArticle => _handbookArticle;

  Future<void> setHandbookArticle(String key) {
    return Future(() {
      this._handbookArticle = key;
    });
  }

  String get pharmaArticle => _pharmaArticle;

  Future<void> setPharmaArticle(String key) {
    return Future(() {
      this._pharmaArticle = key;
    });
  }

  Future<Article> _getArticleByKey(String key) {
    return Future(() {
      Article a = _allArticles[key];
      if (a == null) {
        return Article.unknown(key: key);
      }
      return a;
    });
  }

  Future<List<Article>> _getRelatedArticles(Article article) {
    return Future.wait(article.related.map((k) {
      return _getArticleByKey(k);
    }).toList());
  }

  Future<Article> _getParentArticle(Article article) {
    return _getArticleByKey(article.parent);
  }

  Future<List<Article>> _getChildren(Article article) {
    return Future.wait(article.children.map((a) {
      return _getArticleByKey(a);
    }).toList());
  }

  Future<List<Article>> _getSiblings(Article article) async {
    var parent = await _getParentArticle(article);
    return _getChildren(parent);
  }

  Future<List<ArticleLinkModel>> _getArticleLinks(List<Article> articles) {
    return Future(() {
      return articles.map((x) {
        return ArticleLinkModel(
          key: x.key,
          title: x.title,
          intro: x.intro,
        );
      }).toList();
    });
  }

  Future<List<ArticleModel>> _getArticleModels(List<Article> articles) {
    return Future.wait(articles.map((v) async {
      var relatedArticles = await _getRelatedArticles(v);
      var relatedLinks = await _getArticleLinks(relatedArticles);
      return ArticleModel(
        key: v.key,
        title: v.title,
        date: dateFormatter(v.date),
        byline: v.byline,
        mdcontent: v.mdcontent,
        related: relatedLinks,
      );
    }).toList());
  }

  Future<ArticlePayloadModel> _getArticlePayloadModel(Article a) async {
    var siblings = await _getSiblings(a);
    var index = siblings.indexOf(a);
    var articles = await _getArticleModels(siblings);
    return Future(() {
      return ArticlePayloadModel(
        articles: articles,
        index: index,
      );
    });
  }

  Future<ArticlePayloadModel> getNewsPayload() async {
    var newsArticle = await _getArticleByKey(_newsArticle);
    return _getArticlePayloadModel(newsArticle);
  }

  Future<ArticlePayloadModel> getHandbookPayload() async {
    var handbookArticle = await _getArticleByKey(_handbookArticle);
    return _getArticlePayloadModel(handbookArticle);
  }

  Future<ArticlePayloadModel> getPharmaPayload() async {
    var pharmaArticle = await _getArticleByKey(_pharmaArticle);
    return _getArticlePayloadModel(pharmaArticle);
  }

  Future<DrawerVM> _getDrawerVM(Article a) async {
    var siblings = await _getSiblings(a);
    var parent = await _getParentArticle(a);
    var parentLink = ArticleLinkModel(
      key: parent.key,
      title: parent.title,
      intro: parent.intro,
    );
    var parentArticle = parent.parent.split(globals.linkSeparator)[globals.articleIndex];
    if (parentArticle == globals.rootArticleName) {
      parentLink = null;
    }
    return DrawerVM(
      articleLinks: await _getArticleLinks(siblings),
      parentLink: parentLink,
    );
  }

  Future<DrawerVM> getDrawerVM(int tabIndex) async {
    var current = await _getArticleByKey(_newsArticle);

    if (tabIndex == globals.newsTabIndex) {
      // article already done
    } else if (tabIndex == globals.handbookTabIndex) {
      current = await _getArticleByKey(_handbookArticle);
    } else if (tabIndex == globals.pharmaTabIndex) {
      current = await _getArticleByKey(_pharmaArticle);
    } else if (tabIndex == globals.aboutTabIndex) {
      //current = _getAboutDrawerVM();
    } else {
      print("error");
    }

    return _getDrawerVM(current);
  }
}
