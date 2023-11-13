import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:mediag/screens/authentication/signupScreen.dart';
import 'package:mediag/screens/updateuserdetails/personInfoupdate.dart';
import 'package:mediag/screens/updateuserdetails/personalInfo.dart';
// import 'package:mediag/screens/updateuserdetails/personalInfo.dart';
// import 'package:mediag/screens/updateuserdetails/userupdateprofileview.dart';
// import 'package:mediag/screens/users/patient_welcomescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mediag/screens/userlist_screen/userListScreen.dart';
import 'package:mediag/screens/authentication/signup_screen.dart';
import 'package:mediag/screens/splash/splash_screen.dart';
// import 'package:mediag/screens/authentication/signup_screen.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  late String _user_name;
  String _login_as = '';
  late String _reegitratrionid;
  String? _errorText = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _email;
  String _password = '';

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);

        if (_email == "nayeemx11@gmail.com") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return UserListScreen(registrationid: _reegitratrionid);
              },
            ),
          );
        } else {
          // just normal user will get the remember me feature
          var sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, true);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PersonalInformationCard(this._email, this._reegitratrionid)),
          );

          // if ( == "Nurse"){
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => Nurse_WelcomeScreen(),
          //     ),
          //   );
          // } else if ( == "Patient"){
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => Patient_WelcomeScreen(),
          //     ),
          //   );
          // }
        }
      } catch (error) {
        // Handle login error
      }
    }
  }

  // void showsome() async {
  //   await FirebaseFirestore.instance.collection("users").get().then((event) {
  //     for (var doc in event.docs) {
  //       print("${doc.id} => ${doc.data()}");
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   whereToGo();
  // }

  // void whereToGo() async {

  //   var shared_preferences = await SharedPreferences.getInstance();

  //   var isLoggedIn = shared_preferences.getBool(KEYLOGIN);

  //   Timer(Duration())
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login to App"),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (eValue) {
                    setState(() {
                      _email = eValue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Enter your Email",
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (pValue) {
                    setState(() {
                      _password = pValue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Enter your password",
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (regVelu) {
                    setState(() {
                      _reegitratrionid = regVelu;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "reg ID",
                    labelText: "Enter your reg ID",
                    prefixIcon: Icon(Icons.app_registration),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 56,
                    width: 128,
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: _login,
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 56,
                    width: 128,
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signup_Screen()));
                      },
                      child: Text(
                        "Sign UP",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
