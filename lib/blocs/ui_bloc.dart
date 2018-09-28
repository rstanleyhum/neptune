import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../viewmodels/ui_state.dart';

class UIBloc {
  final _uiState = UIState();
  final _setTabIndexController = StreamController<int>();
  final _setTabIndexByEventController = StreamController<String>();
  final _tabIndexSubject = BehaviorSubject<int>();
  final _tabNameSubject = BehaviorSubject<String>();

  UIBloc() {
    _setTabIndexController.stream.listen(_handleSetTabIndex);
    _setTabIndexByEventController.stream.listen(_handleSetTabIndexByEvent);
  }

  void dispose() {
    _setTabIndexByEventController.close();
    _setTabIndexController.close();
    _tabIndexSubject.close();
    _tabNameSubject.close();
  }

  Sink<int> get setTabIndex => _setTabIndexController.sink;
  Sink<String> get setTabIndexByEvent => _setTabIndexByEventController.sink;
  
  Stream<int> get tabIndex => _tabIndexSubject.stream;
  Stream<String> get tabName => _tabNameSubject.stream;

  void _handleSetTabIndex(int index) {
    _uiState.setTabIndex(index);
    _tabIndexSubject.add(_uiState.tabIndex);
    _tabNameSubject.add(_uiState.tabName);
  }

  void _handleSetTabIndexByEvent(String event) {
    var section = event.split(":")[0];
    if (section == "news") {
      _uiState.setTabIndex(0);
    } else if (section == "handbook") {
      _uiState.setTabIndex(1);
    } else if (section == "pharma") {
      _uiState.setTabIndex(2);
    } else {
      print("ERROR");
      print(event);
    }
    _tabIndexSubject.add(_uiState.tabIndex);
    _tabNameSubject.add(_uiState.tabName);
  }
}
