import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:revisai/Compents/App_widget.dart';
import 'package:revisai/firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(AppWidget());
}