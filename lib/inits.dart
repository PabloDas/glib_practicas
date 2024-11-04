import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:glib_practicas/firebase_options.dart';
import 'package:glib_practicas/utils/app_preferences.dart';

initFirebase() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  log('WidgetsFlutterBinding.ensureInitialized();');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}

initSharedPreferences() async {
  //SHARED PREFERENCES
  final prefs = AppPreferences();
  await prefs.initPrefs();
  log('await prefs.initPreferences();');
}
