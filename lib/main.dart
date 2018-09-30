import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart' as globals;
import 'main_app.dart';

Future<void> main() async {

  final Firestore firestore = new Firestore();
  final FirebaseStorage storage =
      new FirebaseStorage(storageBucket: globals.storageBucketRoot);
  final FirebaseAuth auth = FirebaseAuth.instance;

  await auth.signInAnonymously();
  await firestore.enablePersistence(true);

  final baseDirectory = await getApplicationDocumentsDirectory();
  final imageDir = "${baseDirectory.path}/images/";

  runApp(MainApp(
    firestore: firestore,
    firebaseStorage: storage,
    baseDirectory: baseDirectory,
    imageDir: imageDir,
  ));
}
