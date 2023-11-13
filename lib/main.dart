import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mediag/heartA.dart';
import 'package:mediag/screens/authentication/signup_screen.dart';
import 'package:mediag/screens/splash/splash_screen.dart';
import 'package:mediag/screens/updateuserdetails/personInfoupdate.dart';
import 'package:mediag/screens/updateuserdetails/personalInfo.dart';
// import 'package:mediag/screens/updateuserdetails/update_s/work_personalInfoUpdate.dart';
import 'package:mediag/signup_page.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

Future main() async {
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
        primarySwatch: Colors.deepPurple,
      ),
      // home: WorkPersonalInformationUpdateCard('2014755012@uits.edu.bd', 'n001'),
      // home: personalInfoUpdate('2014755012@uits.edu.bd', 'n001'),
      // home: PersonalInformationCard('2014755012@uits.edu.bd', 'n001'),
      //       PersonalInformationCard
      home: Splash_Screen(),
      // home: Signup_Screen(),
    );
  }
}
