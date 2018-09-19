import 'package:flutter/material.dart';

import '../constants.dart' as globals;
import '../providers/ui_provider.dart';

class TopBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiBloc = UIProvider.of(context);

    return StreamBuilder<String>(
      stream: uiBloc.tabName,
      initialData: globals.initialTabTitle,
      builder: (context, snapshot) {
        return Text(snapshot.data);
      },
    );
  }
}
