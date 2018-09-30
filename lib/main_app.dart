import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'blocs/app_bloc.dart';
import 'providers/app_provider.dart';

import 'widgets/material_base.dart';

class MainApp extends StatelessWidget {
  final Firestore firestore;
  final FirebaseStorage firebaseStorage;
  final Directory baseDirectory;
  final String imageDir;

  MainApp({
    Key key,
    this.firestore,
    this.firebaseStorage,
    this.baseDirectory,
    this.imageDir,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppProvider(
      appBloc: AppBloc(
        firestore: firestore,
        firebaseStorage: firebaseStorage,
        baseAppDirectory: baseDirectory,
        imageDir: imageDir,
      ),
      child: MaterialBase(),
    );
  }
}
