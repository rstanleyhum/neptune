import 'package:flutter/material.dart';

const String storageBucketRoot = "gs://logindemo-5f7b4.appspot.com";
const String firestoreHandbookCollectionURL = "pediatrics/chony/chony_handbook";
const String firestoreNewsCollectionURL = "pediatrics/chony/news";
const String firestorePharmaCollectionURL = "pediatrics/chony/pharma";
const String firestoreChonyImagesCollectionURL =
    "pediatrics/chony/chony_images";
const String firebaseStorageHandbookImagesDir =
    "assets/pediatrics/chony_handbook/images";

const String materialAppTitle = 'MD Handbook';

const String handbookTabTitle = 'Handbook';
const String newsTabTitle = 'News';
const String pharmaTabTitle = 'Pharma';
const String aboutTabTitle = 'About';

const String handbookTabPrefix = 'handbook';
const String newsTabPrefix = 'news';
const String pharmaTabPrefix = 'pharma';
const String aboutTabPrefix = 'about';

const int initialTabIndex = 0;
const int newsTabIndex = 0;
const int handbookTabIndex = 1;
const int pharmaTabIndex = 2;
const int aboutTabIndex = 3;
const String initialTabTitle = newsTabTitle;

const String linkSeparator = "!";
const int prefixIndex = 0;
const int articleIndex = 1;

const String rootArticleName = "index.md";

const String handbookViewportMessage = 'Handbook Viewport';
const String newsViewportMessage = 'News Viewport';
const String pharmaViewportMessage = 'Pharma Viewport';

const String mainDrawerHeaderTitle = 'MD Handbook';
const double mainDrawerHeaderFontSize = 24.0;

const Color themeColor = Colors.blue;

const IconData handbookIcon = Icons.library_books;
const IconData newsIcon = Icons.local_cafe;
const IconData pharmaIcon = Icons.local_pharmacy;
const IconData aboutIcon = Icons.settings;

const String disclaimerTitle = "Disclaimer";
const String disclaimerButtonText = "I accept";

const int splashPageDelay = 3;

const String initialNewsArticle = "news!news1.md";
const String initialHandbookArticle = "handbook!icu_section.md";
const String initialPharmaArticle = "pharma!pharma1.md";

const double defaultHeightOfAndroidStatusBar = 24.0;

const String dateFormat = "yyyy-MM-dd";

const String disclaimerStateKey = "disclaimerState";

const String disclaimerPageTitle = "Disclaimer";
const String disclaimerPageParagraph1 =
    "This is an educational app. It has guidelines and protocols meant as an "
    "reminder aide for trainees at our hospital.";
const String disclaimerPageParagraph2 =
    "It is not expansive nor complete. It should not be used without the "
    "guidance of qualified healthcare professionals and does not replace "
    "clinical judgement. Dosages and treatments may not be completely "
    "up-to-date and should be verified with peer-reviewed sources and/or "
    "institutional references.";
const String disclaimerPageParagraph3 =
    "By pressing the button below and continuing to use this app, you "
    "acknowlege that you understand the limitations of the app and the "
    "educational nature of its contents.";
const String disclaimerPageParagraph4 =
    "By continuing to use this app, you acknowlege that you understand "
    "the limitations of the app and the educational nature of its contents.";

const String aboutDisclaimerTitle = "About / Disclaimer";
const String aboutLicencesTitle = "Licenses";
const String aboutContactUsTitle = "Contact Us";

const String contactUsPageParagraph1 =
    "The content of the app has been created and compiled by the physicians "
    "and nurses working in Children's Hospital at Columbia University "
    "Medical Center. We encourage feedback.";
const String contactUsPageParagraph2 = "Please contact.";
const String contactUsPageParagraph3 = "R. Stanley Hum, MD\n"
    "Assistant Professor of Pediatrics at CUMC\n"
    "Columbia University\n"
    "3959 Broadway, CHN 10-31\n"
    "New York, NY, 10032\n"
    "(212) 305-8458\n"
    "\n"
    "rsh2117@cumc.columbia.edu";
