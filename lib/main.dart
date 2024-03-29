import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vocalgroups/App/app.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(App());
}
