import 'article.dart';

class ArticleStore {
  Map<String, Article> _allArticles;

  bool _loading;
  bool _loaded;

  ArticleStore() {
    this._allArticles = {};
    this._loading = false;
    this._loaded = false;
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

  Article getArticleByKey(String key) {
    return _allArticles[key];
  }

  List<Article> getRelatedArticles(Article article) {
    return article.related.map((a) {
      return getArticleByKey(a);
    }).toList();
  }

  Article getParentArticle(Article article) {
    return getArticleByKey(article.parent);
  }

  List<Article> getChildren(Article article) {
    return article.children.map((a) {
      return getArticleByKey(a);
    }).toList();
  }

  List<Article> getSiblings(Article article) {
    var parent = getParentArticle(article);
    return getChildren(parent);
  }
  
}
