import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

import '../constants.dart' as globals;

import '../models/article.dart';

import '../viewmodels/article_store.dart';
import '../viewmodels/article_payload.dart';
import '../viewmodels/app_state.dart';
import '../viewmodels/drawer_vm.dart';

class AppBloc {
  static FirebaseAnalytics analytics = new FirebaseAnalytics();

  final Firestore firestore;
  final FirebaseStorage firebaseStorage;
  final Directory baseAppDirectory;
  final String imageDir;

  final _appState = AppState();
  final _articleStore = ArticleStore();

  final _setTabIndexController = StreamController<int>();
  final _setArticleEventController = StreamController<String>();

  final _updateNewsArticle = StreamController<String>();
  final _updateHandbookArticle = StreamController<String>();
  final _updatePharmaArticle = StreamController<String>();

  final _notifyNewArticlesLoaded = StreamController<int>();

  final _tabIndexSubject = BehaviorSubject<int>();
  final _isLoadingSubject = BehaviorSubject<bool>();
  final _isLoadedSubject = BehaviorSubject<bool>();
  final _newsPayloadSubject = BehaviorSubject<ArticlePayloadModel>();
  final _handbookPayloadSubject = BehaviorSubject<ArticlePayloadModel>();
  final _pharmaPayloadSubject = BehaviorSubject<ArticlePayloadModel>();
  final _drawerVMSubject = BehaviorSubject<DrawerVM>();

  bool _selectingArticle;

  Sink<int> get setTabIndex => _setTabIndexController.sink;
  Sink<String> get sendArticleSelect => _setArticleEventController.sink;

  Sink<String> get sendNewsUpdate => _updateNewsArticle.sink;
  Sink<String> get sendHandbookUpdate => _updateHandbookArticle.sink;
  Sink<String> get sendPharmaUpdate => _updatePharmaArticle.sink;

  Stream<int> get tabIndex => _tabIndexSubject.stream;
  Stream<bool> get isLoading => _isLoadingSubject.stream;
  Stream<bool> get isLoaded => _isLoadedSubject.stream;
  Stream<ArticlePayloadModel> get newsPayload => _newsPayloadSubject.stream;
  Stream<ArticlePayloadModel> get handbookPayload =>
      _handbookPayloadSubject.stream;
  Stream<ArticlePayloadModel> get pharmaPayload => _pharmaPayloadSubject.stream;
  Stream<DrawerVM> get drawerVMPayload => _drawerVMSubject.stream;

  AppBloc({
    this.firestore,
    this.firebaseStorage,
    this.baseAppDirectory,
    this.imageDir,
  }) {
    _selectingArticle = false;
    _createImagesDirectory();
    _setUpListeners();
    _loadArticles();
  }

  void dispose() {
    _setTabIndexController.close();
    _tabIndexSubject.close();
    _notifyNewArticlesLoaded.close();

    _setArticleEventController.close();

    _updateHandbookArticle.close();
    _updateNewsArticle.close();
    _updatePharmaArticle.close();

    _isLoadingSubject.close();
    _isLoadedSubject.close();
    _newsPayloadSubject.close();
    _handbookPayloadSubject.close();
    _pharmaPayloadSubject.close();
  }

  void _setUpListeners() {
    firestore
        .collection(globals.firestoreHandbookCollectionURL)
        .snapshots()
        .listen(_handleFirestoreHandbookCollection);

    firestore
        .collection(globals.firestoreNewsCollectionURL)
        .snapshots()
        .listen(_handleFirestoreNewsCollection);
    firestore
        .collection(globals.firestorePharmaCollectionURL)
        .snapshots()
        .listen(_handleFirestorePharmaCollection);

    firestore
        .collection(globals.firestoreChonyImagesCollectionURL)
        .snapshots()
        .listen(_handleFirestoreChonyImagesCollection);

    _setTabIndexController.stream.listen(_handleSetTabIndex);
    _setArticleEventController.stream.listen(_handleSelectArticleEvent);

    _updateHandbookArticle.stream.listen(_handleHandbookUpdateEvent);
    _updateNewsArticle.stream.listen(_handleNewsUpdateEvent);
    _updatePharmaArticle.stream.listen(_handlePharmaUpdateEvent);

    _notifyNewArticlesLoaded.stream.listen(_handleNewArticlesLoaded);
  }

  void _handleSetTabIndex(int index) async {
    _appState.setTabIndex(index);
    _tabIndexSubject.add(_appState.tabIndex);
    _drawerVMSubject.add(await _articleStore.getDrawerVM(_appState.tabIndex));
    analytics.logEvent(
      name: 'handleSetTabIndex',
      parameters: <String, dynamic>{
        'index': index,
      },
    );
  }

  void _loadArticles() async {
    await _articleStore.setNewsArticle(globals.initialNewsArticle);
    await _articleStore.setHandbookArticle(globals.initialHandbookArticle);
    await _articleStore.setPharmaArticle(globals.initialPharmaArticle);
    analytics.logEvent(
      name: 'Loaded_articles_event',
      parameters: <String, dynamic>{
        'bool': true,
      },
    );
  }

  void _handleSelectArticleEvent(String event) async {
    if (_selectingArticle) {
      return;
    }

    _selectingArticle = true;

    var section = event.split(globals.linkSeparator)[globals.prefixIndex];
    if (section == globals.newsTabPrefix) {
      await _articleStore.setNewsArticle(event);
      var newsPayload = await _articleStore.getNewsPayload();
      _newsPayloadSubject.add(newsPayload);
      _appState.setTabIndex(globals.newsTabIndex);
    } else if (section == globals.handbookTabPrefix) {
      await _articleStore.setHandbookArticle(event);
      var handbookPayload = await _articleStore.getHandbookPayload();
      _handbookPayloadSubject.add(handbookPayload);
      _appState.setTabIndex(globals.handbookTabIndex);
    } else if (section == globals.pharmaTabPrefix) {
      await _articleStore.setPharmaArticle(event);
      var pharmaPayload = await _articleStore.getPharmaPayload();
      _pharmaPayloadSubject.add(pharmaPayload);
      _appState.setTabIndex(globals.pharmaTabIndex);
    } else {
      analytics.logEvent(
        name: 'handleSelectArticelEvent_ERROR',
        parameters: <String, dynamic>{
          'event': event,
        },
      );
      _selectingArticle = false;
      return;
    }

    _tabIndexSubject.add(_appState.tabIndex);

    _drawerVMSubject.add(await _articleStore.getDrawerVM(_appState.tabIndex));
    analytics.logEvent(
      name: 'handleSelectArticleEvent_SUCCESS',
      parameters: <String, dynamic>{
        'event': event,
      },
    );
    _selectingArticle = false;
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

  void _handleFirestoreHandbookCollection(QuerySnapshot event) async {
    _appState.setHandbookArticlesLoading(true);
    Map<String, Article> allArticles = {};
    event.documents.forEach((d) {
      Article a = _createArticleFromQueryDoc(d);
      allArticles[a.key] = a;
    });
    await _articleStore.addAllArticles(allArticles);
    _appState.setHandbookArticlesLoading(false);
    _notifyNewArticlesLoaded.add(globals.handbookTabIndex);
  }

  void _handleFirestoreNewsCollection(QuerySnapshot event) async {
    _appState.setNewsArticlesLoading(true);
    Map<String, Article> allArticles = {};
    event.documents.forEach((d) {
      Article a = _createArticleFromQueryDoc(d);
      allArticles[a.key] = a;
    });
    await _articleStore.addAllArticles(allArticles);
    _appState.setNewsArticlesLoading(false);
    _notifyNewArticlesLoaded.add(globals.newsTabIndex);
  }

  void _handleFirestorePharmaCollection(QuerySnapshot event) async {
    _appState.setPharmaArticlesLoading(true);
    Map<String, Article> allArticles = {};
    event.documents.forEach((d) {
      Article a = _createArticleFromQueryDoc(d);
      allArticles[a.key] = a;
    });
    await _articleStore.addAllArticles(allArticles);
    _appState.setPharmaArticlesLoading(false);
    _notifyNewArticlesLoaded.add(globals.pharmaTabIndex);
  }

  void _handleFirestoreChonyImagesCollection(QuerySnapshot event) {
    event.documents.forEach((d) {
      var objectName = d.data['objectName'];
      var bucketName = d.data['bucketName'];

      _loadAndSaveImage(objectName, bucketName);
    });
  }

  Future<void> _loadAndSaveImage(String fn, String b) async {
    var filename = "$imageDir${fn.toLowerCase()}";

    if (await File(filename).exists()) {
      return;
    }

    try {
      firebaseStorage
          .ref()
          .child(globals.firebaseStorageHandbookImagesDir)
          .child(fn)
          .writeToFile(File(filename));
    } catch (e) {
      print(e);
    }
  }

  void _createImagesDirectory() async {
    await Directory(imageDir)
        .create(recursive: true)
        .then((Directory directory) {})
        .catchError((e) {
      print(e);
    });
  }

  void _handleNewArticlesLoaded(int event) async {
    if (_appState.articlesLoaded) {
      _newsPayloadSubject.add(await _articleStore.getNewsPayload());
      _handbookPayloadSubject.add(await _articleStore.getHandbookPayload());
      _pharmaPayloadSubject.add(await _articleStore.getPharmaPayload());
      _drawerVMSubject.add(await _articleStore.getDrawerVM(_appState.tabIndex));
    }
  }

  void _handleHandbookUpdateEvent(String event) async {
    await _articleStore.setHandbookArticle(event);
  }

  void _handleNewsUpdateEvent(String event) async {
    await _articleStore.setNewsArticle(event);
  }

  void _handlePharmaUpdateEvent(String event) async {
    await _articleStore.setPharmaArticle(event);
  }
}
