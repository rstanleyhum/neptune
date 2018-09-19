import 'package:flutter/material.dart';

import '../blocs/ui_bloc.dart';

class UIProvider extends InheritedWidget {
  final UIBloc uiBloc;

  const UIProvider({
    Key key,
    @required this.uiBloc,
    @required Widget child,
  }) : super(key: key, child: child);

  static UIBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(UIProvider) as UIProvider).uiBloc;
  }

  @override
  bool updateShouldNotify(UIProvider old) => uiBloc != old.uiBloc;
}
