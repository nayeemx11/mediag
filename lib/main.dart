import 'package:firebase_core/firebase_core.dart';
import 'package:mediag/screens/splash/splash_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized(); // Ensure plugin initialization


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical diagnostics Share',
      theme: ThemeData(
        primarySwatch: Colors.green,

      ),
      home: Splash_Screen(),
    );
  }
}
