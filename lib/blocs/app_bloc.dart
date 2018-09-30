import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:rxdart/rxdart.dart';

import '../constants.dart' as globals;

import '../models/article.dart';

import '../viewmodels/article_store.dart';
import '../viewmodels/article_payload.dart';
import '../viewmodels/ui_state.dart';
import '../viewmodels/drawer_vm.dart';

import '../services/local_service.dart';

class AppBloc {
  final Firestore firestore;

  static FirebaseAnalytics analytics = new FirebaseAnalytics();

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

  AppBloc({
    this.firestore,
  }) {
    firestore
        .collection('pediatrics/chony/chony_handbook')
        .snapshots()
        .listen(_handleFirestoreHandbookCollection);

    firestore
        .collection('pediatrics/chony/news')
        .snapshots()
        .listen(_handleFirestoreNewsCollection);
    firestore
        .collection('pediatrics/chony/pharma')
        .snapshots()
        .listen(_handleFirestorePharmaCollection);
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
    analytics.logEvent(
      name: 'handleSetTabIndex',
      parameters: <String, dynamic>{
        'index': index,
      },
    );
  }

  void loadArticles() async {
    _articleStore.setLoading();
    _isLoadingSubject.add(_articleStore.isLoading);
    await LocalService.loadImages();
    _articleStore.setNewsArticle(globals.initialNewsArticle);
    _articleStore.setHandbookArticle(globals.initialHandbookArticle);
    _articleStore.setPharmaArticle(globals.initialPharmaArticle);
    _articleStore.setLoaded();
    analytics.logEvent(
      name: 'Loaded_articles_event',
      parameters: <String, dynamic>{
        'bool': true,
      },
    );
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
    var section = event.split("!")[0];
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
      analytics.logEvent(
        name: 'handleSelectArticelEvent_ERROR',
        parameters: <String, dynamic>{
          'event': event,
        },
      );
      return;
    }
    _tabIndexSubject.add(_uiState.tabIndex);
    _tabNameSubject.add(_uiState.tabName);

    _drawerVMSubject.add(_articleStore.getDrawerVM(_uiState.tabIndex));
    analytics.logEvent(
      name: 'handleSelectArticleEvent_SUCCESS',
      parameters: <String, dynamic>{
        'event': event,
      },
    );
  }

  Article _createArticleFromQueryDoc(DocumentSnapshot d) {
    String key = d.data['key'] as String;
    String title = d.data['title'] as String ?? "";
    DateTime date = d.data['date'] as DateTime;
    String intro = d.data['intro'] as String ?? "";
    String byline = d.data['byline'] as String ?? "";
    String parent = d.data['parent'] as String;
    String mdcontent = d.data['mdcontent'] as String ?? "";
    List<String> children = [];
    List<String> related = [];

    if (key == null || parent == null) {
      //error
      key = 'ERROR';
      parent = 'ERROR';
      print("ERROR: ${d.data}");
    }

    if (d.data.containsKey('children')) {
      var l = d.data['children'] as List;
      if (l.length != 0) {
        children = l.map((v) {
          return v as String;
        }).toList();
      }
    }

    if (d.data.containsKey('related')) {
      var l = d.data['related'] as List;
      if (l.length != 0) {
        related = l.map((v) {
          return v as String;
        }).toList();
      }
    }

    return Article(
      key: key,
      title: title,
      date: date,
      intro: intro,
      byline: byline,
      parent: parent,
      mdcontent: mdcontent,
      children: children,
      related: related,
    );
  }

  void _handleFirestoreHandbookCollection(QuerySnapshot event) {
    Map<String, Article> allArticles = {};
    event.documents.forEach((d) {
      Article a = _createArticleFromQueryDoc(d);
      allArticles[a.key] = a;
    });
    _articleStore.addAllArticles(allArticles);
  }

  void _handleFirestoreNewsCollection(QuerySnapshot event) {
    Map<String, Article> allArticles = {};
    event.documents.forEach((d) {
      Article a = _createArticleFromQueryDoc(d);
      allArticles[a.key] = a;
    });
    _articleStore.addAllArticles(allArticles);
  }

  void _handleFirestorePharmaCollection(QuerySnapshot event) {
    Map<String, Article> allArticles = {};
    event.documents.forEach((d) {
      Article a = _createArticleFromQueryDoc(d);
      allArticles[a.key] = a;
    });
    _articleStore.addAllArticles(allArticles);
  }
}
