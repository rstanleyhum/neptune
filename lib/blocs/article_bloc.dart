import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../constants.dart' as globals;

import '../models/article.dart';
import '../viewmodels/article_store.dart';
import '../viewmodels/article_payload.dart';
import '../services/local_service.dart';

class ArticleBloc {
  final _articleStore = ArticleStore();

  final _setArticleEventController = StreamController<String>();

  final _isLoadingSubject = BehaviorSubject<bool>();
  final _isLoadedSubject = BehaviorSubject<bool>();

  final _newsPayloadSubject = BehaviorSubject<ArticlePayloadModel>();
  final _handbookPayloadSubject = BehaviorSubject<ArticlePayloadModel>();
  final _pharmaPayloadSubject = BehaviorSubject<ArticlePayloadModel>();

  ArticleBloc() {
    loadArticles();
    _setArticleEventController.stream.listen(_handleSelectArticleEvent);
  }

  void dispose() {
    _setArticleEventController.close();
    _isLoadingSubject.close();
    _isLoadedSubject.close();
    _newsPayloadSubject.close();
    _handbookPayloadSubject.close();
    _pharmaPayloadSubject.close();
  }

  Sink<String> get sendArticleSelect => _setArticleEventController.sink;

  Stream<bool> get isLoading => _isLoadingSubject.stream;
  Stream<bool> get isLoaded => _isLoadedSubject.stream;

  Stream<ArticlePayloadModel> get newsPayload => _newsPayloadSubject.stream;
  Stream<ArticlePayloadModel> get handbookPayload =>
      _handbookPayloadSubject.stream;
  Stream<ArticlePayloadModel> get pharmaPayload => _pharmaPayloadSubject.stream;

  void loadArticles() async {
    _articleStore.setLoading();
    _isLoadingSubject.add(_articleStore.isLoading);
    var articles = await LocalService.loadArticles();
    await LocalService.loadImages();
    await Future.delayed(Duration(seconds: globals.loadArticlesDelay));
    Map<String, Article> allArticles = {};
    articles.forEach((a) {
      allArticles[a.key] = a;
    });
    _articleStore.setAllArticles(allArticles);
    _articleStore.setNewsArticle(globals.initialNewsArticle);
    _articleStore.setHandbookArticle(globals.initialHandbookArticle);
    _articleStore.setPharmaArticle(globals.initialPharmaArticle);
    _articleStore.setLoaded();
    _newsPayloadSubject.add(_articleStore.getNewsPayload());
    _handbookPayloadSubject.add(_articleStore.getHandbookPayload());
    _pharmaPayloadSubject.add(_articleStore.getPharmaPayload());
    _isLoadedSubject.add(_articleStore.isLoaded);
    _isLoadingSubject.add(_articleStore.isLoading);
  }

  
  void _handleSelectArticleEvent(String event) {
    var parts = event.split(":");
    var section = parts[0];
    var articleKey = parts[1];
    print(section);
    print(articleKey);
    if (section == "news") {
      _articleStore.setNewsArticle(event);
      _newsPayloadSubject.add(_articleStore.getNewsPayload());
    } else if (section == "handbook") {
      _articleStore.setHandbookArticle(event);
      _handbookPayloadSubject.add(_articleStore.getHandbookPayload());
    } else if (section == "pharma") {
      _articleStore.setPharmaArticle(event);
      _pharmaPayloadSubject.add(_articleStore.getPharmaPayload());
    } else {
      print("Section selection error");
      print(event);
      print(section);
      print(articleKey);
    }
  }
}
