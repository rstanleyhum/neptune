import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../constants.dart' as globals;

import '../models/article.dart';

import '../viewmodels/article_store.dart';
import '../viewmodels/article_payload.dart';
import '../viewmodels/ui_state.dart';
import '../viewmodels/drawer_vm.dart';

import '../services/local_service.dart';

class AppBloc {
  final _uiState = UIState();
  final _articleStore = ArticleStore();

  final _setTabIndexController = StreamController<int>();

  final _setArticleEventController = StreamController<String>();

  final _tabIndexSubject = BehaviorSubject<int>();
  final _tabNameSubject = BehaviorSubject<String>();

  final _isLoadingSubject = BehaviorSubject<bool>();
  final _isLoadedSubject = BehaviorSubject<bool>();

  final _newsPayloadSubject = BehaviorSubject<ArticlePayloadModel>();
  final _handbookPayloadSubject = BehaviorSubject<ArticlePayloadModel>();
  final _pharmaPayloadSubject = BehaviorSubject<ArticlePayloadModel>();
  final _drawerVMSubject = BehaviorSubject<DrawerVM>();


  AppBloc() {
    _setTabIndexController.stream.listen(_handleSetTabIndex);

    loadArticles();
    _setArticleEventController.stream.listen(_handleSelectArticleEvent);
  }


  void dispose() {
    _setTabIndexController.close();
    _tabIndexSubject.close();
    _tabNameSubject.close();
    _setArticleEventController.close();
    _isLoadingSubject.close();
    _isLoadedSubject.close();
    _newsPayloadSubject.close();
    _handbookPayloadSubject.close();
    _pharmaPayloadSubject.close();
  }

  Sink<int> get setTabIndex => _setTabIndexController.sink;

  Sink<String> get sendArticleSelect => _setArticleEventController.sink;

  Stream<int> get tabIndex => _tabIndexSubject.stream;
  Stream<String> get tabName => _tabNameSubject.stream;

  Stream<bool> get isLoading => _isLoadingSubject.stream;
  Stream<bool> get isLoaded => _isLoadedSubject.stream;

  Stream<ArticlePayloadModel> get newsPayload => _newsPayloadSubject.stream;
  Stream<ArticlePayloadModel> get handbookPayload =>
      _handbookPayloadSubject.stream;
  Stream<ArticlePayloadModel> get pharmaPayload => _pharmaPayloadSubject.stream;

  Stream<DrawerVM> get drawerVMPayload => _drawerVMSubject.stream;

  void _handleSetTabIndex(int index) {
    _uiState.setTabIndex(index);
    _tabIndexSubject.add(_uiState.tabIndex);
    _tabNameSubject.add(_uiState.tabName);
    _drawerVMSubject.add(_articleStore.getDrawerVM(_uiState.tabIndex));
  }


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
    _uiState.setTabIndex(0);
    _drawerVMSubject.add(_articleStore.getDrawerVM(_uiState.tabIndex));
    _tabIndexSubject.add(_uiState.tabIndex);
    _tabNameSubject.add(_uiState.tabName);
  }


  void _handleSelectArticleEvent(String event) {
    var section = event.split(":")[0];
    if (section == "news") {
      _articleStore.setNewsArticle(event);
      _newsPayloadSubject.add(_articleStore.getNewsPayload());
      _uiState.setTabIndex(0);
    } else if (section == "handbook") {
      _articleStore.setHandbookArticle(event);
      _handbookPayloadSubject.add(_articleStore.getHandbookPayload());
      _uiState.setTabIndex(1);
    } else if (section == "pharma") {
      _articleStore.setPharmaArticle(event);
      _pharmaPayloadSubject.add(_articleStore.getPharmaPayload());
      _uiState.setTabIndex(2);
    } else {
      print("Section selection error");
      print(event);
    }
    _tabIndexSubject.add(_uiState.tabIndex);
    _tabNameSubject.add(_uiState.tabName);

    _drawerVMSubject.add(_articleStore.getDrawerVM(_uiState.tabIndex));
  }
}
