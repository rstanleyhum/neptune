import 'package:flutter/material.dart';

import '../blocs/app_bloc.dart';

class AppProvider extends InheritedWidget {
  final AppBloc appBloc;

  const AppProvider({
    Key key,
    @required this.appBloc,
    @required Widget child,
  }) : super(key: key, child: child);

  static AppBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider).appBloc;
  }

  @override
  bool updateShouldNotify(AppProvider old) => appBloc != old.appBloc;
}
