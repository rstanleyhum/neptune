import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'main_app.dart';

Future<void> main() async {

  //MaterialPageRoute.debugEnableFadingRoutes = true;
  
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'com.stanleyhum.neptune',
    options: const FirebaseOptions(
      googleAppID: '1:567254085450:android:5d91f953d8fbc537',
      gcmSenderID: '567254085450',
      apiKey: 'AIzaSyBtHKFm-y3VsDsNtnvjY7oNWk0XsPbjPMU',
      projectID: 'logindemo-5f7b4',
    ),
  );

  final Firestore firestore = new Firestore(app: app);

  await firestore.enablePersistence(true);

  runApp(MainApp(
    firestore: firestore,
  ));
}
