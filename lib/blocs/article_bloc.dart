import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/article.dart';
import '../models/article_store.dart';
import '../services/local_service.dart';

class ArticleBloc {
  final _articleStore = ArticleStore();
  final _isLoadingSubject = BehaviorSubject<bool>();
  final _isLoadedSubject = BehaviorSubject<bool>();

  ArticleBloc() {
    loadArticles();
  }

  void dispose() {
    _isLoadingSubject.close();
    _isLoadedSubject.close();
  }

  Stream<bool> get isLoading => _isLoadingSubject.stream;
  Stream<bool> get isLoaded => _isLoadedSubject.stream;

  void loadArticles() async {
    _articleStore.setLoading();
    _isLoadingSubject.add(_articleStore.isLoading);
    var articles = await LocalService.loadArticles();
    await Future.delayed(Duration(seconds: 5));
    Map<String, Article> allArticles = {};
    articles.forEach((a) {
      allArticles[a.key] = a;
    });
    _articleStore.setAllArticles(allArticles);
    _articleStore.setLoaded();
    _isLoadedSubject.add(_articleStore.isLoaded);
    _isLoadingSubject.add(_articleStore.isLoading);
  }
}
