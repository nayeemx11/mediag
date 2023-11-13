import 'package:flutter/material.dart';
import 'package:mediag/screens/authentication/login_screen.dart';
import 'package:mediag/screens/updateuserdetails/personalInfo.dart';
import 'package:mediag/screens/users/patient_welcomescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => Splash_ScreenState();
}

class Splash_ScreenState extends State<Splash_Screen> {
  static const String KEYLOGIN = "Login";
  static const String KEY_EMAIL = "Email";
  static const String KEY_REG = "REG";

  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  void whereToGo() async {
    var shared_preferences = await SharedPreferences.getInstance();

    var isLoggedIn = shared_preferences.getBool(KEYLOGIN);

    if (isLoggedIn != null) {
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PersonalInformationCard(KEY_EMAIL, KEY_REG,),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login_Screen(),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login_Screen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Hi this splash screen will be implemented soon"),
    );
  }
}


    // Timer(Duration(seconds: 2), () {
    //   if (isLoggedIn != null) {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => login_Screen(),
    //       ),
    //     );
    //   } else {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => WelcomeScreen(),
    //       ),
    //     );
    //   }
    // });