import 'package:flutter/material.dart';

import 'blocs/ui_bloc.dart';

import 'widgets/material_base.dart';

import 'providers/ui_provider.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UIProvider(
      uiBloc: UIBloc(),
      child: MaterialBase(),
    );
  }
}
