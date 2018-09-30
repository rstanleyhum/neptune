import 'package:flutter/material.dart';


const String storageBucketRoot = "gs://logindemo-5f7b4.appspot.com";
const String firestoreHandbookCollectionURL = "pediatrics/chony/chony_handbook";
const String firestoreNewsCollectionURL = "pediatrics/chony/news";
const String firestorePharmaCollectionURL = "pediatrics/chony/pharma";
const String firestoreChonyImagesCollectionURL = "pediatrics/chony/chony_images";
const String firebaseStorageHandbookImagesDir = "assets/pediatrics/chony_handbook/images";

const String materialAppTitle = 'Neptune Demo';

const String handbookTabTitle = 'Handbook';
const String newsTabTitle = 'News';
const String pharmaTabTitle = 'Pharma';

const int initialTabIndex = 0;
const int newsTabIndex = 0;
const int handbookTabIndex = 1;
const int pharmaTabIndex = 2;
const String initialTabTitle = newsTabTitle;


const String handbookViewportMessage = 'Handbook Viewport';
const String newsViewportMessage = 'News Viewport';
const String pharmaViewportMessage = 'Pharma Viewport';

const String mainDrawerHeaderTitle = 'MD Handbook';
const double mainDrawerHeaderFontSize = 24.0;

const String drawerItemOne = 'Item 1';
const String drawerItemTwo = 'Item 2';

const Color themeColor = Colors.blue;

const IconData handbookIcon = Icons.library_books;
const IconData newsIcon = Icons.local_cafe;
const IconData pharmaIcon = Icons.local_pharmacy;

const String splashPageTitle = "Splash Page";
const String disclaimerTitle = "Disclaimer";
const String disclaimerButtonText = "I accept";

const int loadArticlesDelay = 5; // for debugging
const int splashPageDelay = 3;

const String initialNewsArticle = "news!news1.md";
const String initialHandbookArticle = "handbook!icu_section.md";
const String initialPharmaArticle = "pharma!pharma1.md";

const double defaultHeightOfAndroidStatusBar = 24.0;