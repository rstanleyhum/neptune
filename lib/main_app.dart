import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'blocs/app_bloc.dart';
import 'providers/app_provider.dart';

import 'widgets/material_base.dart';

class MainApp extends StatelessWidget {
  final Firestore firestore;

  MainApp({
    Key key,
    this.firestore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      appBloc: AppBloc(
        firestore: firestore,
      ),
      child: MaterialBase(),
    );
  }
}
