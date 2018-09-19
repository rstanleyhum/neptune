import '../constants.dart' as globals;

class UIState {
  static const _tabNames = [
    globals.newsTabTitle,
    globals.handbookTabTitle,
    globals.pharmaTabTitle,
  ];

  int _tabIndex;
  String _tabName;

  UIState() {
    this._tabIndex = globals.initialTabIndex;
    this._tabName = globals.newsTabTitle;
  }

  int get tabIndex => _tabIndex;
  String get tabName => _tabName;

  void setTabIndex(int index) {
    _tabIndex = index;
    _tabName = _tabNames[_tabIndex];
  }
}
