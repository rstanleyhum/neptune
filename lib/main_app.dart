import 'package:flutter/material.dart';

import 'blocs/app_bloc.dart';
import 'providers/app_provider.dart';

import 'widgets/material_base.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppProvider(
      appBloc: AppBloc(),
      child: MaterialBase(),
    );
  }
}
