import 'package:firebase_core/firebase_core.dart';
import 'auth_screen.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';

// import 'package:mediag/pages/login_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}



/// not main
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical diagnostics Share',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: AuthScreen(),
    );
  }
}




/// main 

// class MyApp extends StatelessWidget {
//   MyApp({super.key});

//   // this is my root of applicationn
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Medical diagnostics center",
//       home: SignUp(),
//       // AuthPage(),
//     );
//   }
// }
