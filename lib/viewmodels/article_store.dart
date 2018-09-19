import '../models/article.dart';

import 'article_payload.dart';

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

  void setAllArticles(Map<String, Article> articles) {
    this._allArticles = articles;
  }

  String get newsArticle => _newsArticle;
  void setNewsArticle(String key) {
    this._newsArticle = key;
  }

  String get handbookArticle => _handbookArticle;
  void setHandbookArticle(String key) {
    this._handbookArticle = key;
  }

  String get pharmaArticle => _pharmaArticle;
  void setPharmaArticle(String key) {
    this._pharmaArticle = key;
  }

  Article _getArticleByKey(String key) {
    return _allArticles[key];
  }

  List<Article> _getRelatedArticles(Article article) {
    return article.related.map((a) {
      var v = _getArticleByKey(a);
      if (v == null) {
        return Article(
            key: a,
            title: "",
            date: null,
            intro: "",
            byline: "",
            parent: "",
            mdcontent: "",
            children: <String>[],
            related: <String>[]);
      }
      return v;
    }).toList();
  }

  Article _getParentArticle(Article article) {
    return _getArticleByKey(article.parent);
  }

  List<Article> _getChildren(Article article) {
    return article.children.map((a) {
      return _getArticleByKey(a);
    }).toList();
  }

  List<Article> _getSiblings(Article article) {
    var parent = _getParentArticle(article);
    return _getChildren(parent);
  }

  List<ArticleLinkModel> _getArticleLinks(List<Article> articles) {
    return articles.map((x) {
      return ArticleLinkModel(
        key: x.key,
        title: x.title,
        intro: x.intro,
      );
    }).toList();
  }

  List<ArticleModel> _getArticleModels(List<Article> articles) {
    return articles.map((v) {
      return ArticleModel(
        key: v.key,
        title: v.title,
        date: "${v.date}",
        byline: v.byline,
        mdcontent: v.mdcontent,
        related: _getArticleLinks(_getRelatedArticles(v)),
      );
    }).toList();
  }

  ArticlePayloadModel _getArticlePayloadModel(Article a) {
    var siblings = _getSiblings(a);
    return ArticlePayloadModel(
      articles: _getArticleModels(siblings),
      index: siblings.indexOf(a),
    );
  }

  ArticlePayloadModel getNewsPayload() {
    var newsArticle = _getArticleByKey(_newsArticle);
    return _getArticlePayloadModel(newsArticle);
  }

  ArticlePayloadModel getHandbookPayload() {
    var handbookArticle = _getArticleByKey(_handbookArticle);
    return _getArticlePayloadModel(handbookArticle);
  }

  ArticlePayloadModel getPharmaPayload() {
    var pharmaArticle = _getArticleByKey(_pharmaArticle);
    return _getArticlePayloadModel(pharmaArticle);
  }
}
