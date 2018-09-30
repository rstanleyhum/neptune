import '../constants.dart' as globals;

class AppState {
  int _tabIndex;

  bool _newsArticlesLoading;
  bool _newsArticlesLoaded;

  bool _handbookArticlesLoading;
  bool _handbookArticlesLoaded;

  bool _pharmaArticlesLoading;
  bool _pharmaArticlesLoaded;


  
  AppState() {
    this._tabIndex = globals.initialTabIndex;

    this._newsArticlesLoaded = false;
    this._newsArticlesLoading = true;

    this._handbookArticlesLoaded = false;
    this._handbookArticlesLoading = true;

    this._pharmaArticlesLoaded = false;
    this._pharmaArticlesLoading = true;
  }

  int get tabIndex => _tabIndex;
  void setTabIndex(int i) {
    _tabIndex = i;
  }

  bool get newsArticlesLoading => _newsArticlesLoading;
  void setNewsArticlesLoading(bool v) {
    _newsArticlesLoading = v;
  }

  bool get newsArticlesLoaded => _newsArticlesLoaded;
  void setNewsArticlesLoaded(bool v) {
    _newsArticlesLoaded = v;
  }

  bool get handbookArticlesLoading => _handbookArticlesLoading;
  void setHandbookArticlesLoading(bool v) {
    _handbookArticlesLoading = v;
  }

  bool get handbookArticlesLoaded => _handbookArticlesLoaded;
  void setHandbookArticlesLoaded(bool v) {
    _handbookArticlesLoaded = v;
  }

  bool get pharmaArticlesLoading => _pharmaArticlesLoading;
  void setPharmaArticlesLoading(bool v) {
    _pharmaArticlesLoading = v;
  }

  bool get pharmaArticlesLoaded => _pharmaArticlesLoaded;
  void setPharmaArticlesLoaded(bool v) {
    _pharmaArticlesLoaded = v;
  }

  bool get articlesLoaded => !_newsArticlesLoading && !_pharmaArticlesLoading && !_handbookArticlesLoading;
}