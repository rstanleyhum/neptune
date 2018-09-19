import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/ui_state.dart';

class UIBloc {
  final _uiState = UIState();
  final _setTabIndexController = StreamController<int>();
  final _tabIndexSubject = BehaviorSubject<int>();
  final _tabNameSubject = BehaviorSubject<String>();

  UIBloc() {
    _setTabIndexController.stream.listen(_handleSetTabIndex);
  }

  void dispose() {
    _setTabIndexController.close();
  }

  Sink<int> get setTabIndex => _setTabIndexController.sink;
  Stream<int> get tabIndex => _tabIndexSubject.stream;
  Stream<String> get tabName => _tabNameSubject.stream;

  void _handleSetTabIndex(int index) {
    _uiState.setTabIndex(index);
    _tabIndexSubject.add(_uiState.tabIndex);
    _tabNameSubject.add(_uiState.tabName);
  }
}
