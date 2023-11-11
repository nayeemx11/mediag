import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediag/screens/updateuserdetails/userupdateprofileview.dart';
import 'package:mediag/screens/users/patient_welcomescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mediag/screens/userlist_screen/userListScreen.dart';
import 'package:mediag/screens/authentication/signup_screen.dart';
import 'package:mediag/screens/splash/splash_screen.dart';

class login_Screen extends StatefulWidget {
  const login_Screen({super.key});

  @override
  State<login_Screen> createState() => _login_ScreenState();
}

class _login_ScreenState extends State<login_Screen> {
  String _user_name = '';
  String _login_as = '';
  String _reegitratrionid = '';
  String? _errorText = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);

        if (_email == "nayeemx11@gmail.com") {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return UserListScreen(registrationid: _reegitratrionid);
            },
          )
              // MaterialPageRoute(
              //     builder: (context) => UserListScreen(
              //           email: _email,
              //           login_as: _login_as,
              //           password: _password,
              //           reegitratrionid: _reegitratrionid,
              //           user_name: _user_name,
              //         )),
              );
        } else {
          // just normal user will get the remember me feature
          var sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, true);

          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => Patient_WelcomeScreen()),
          // );
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => UserProfilePage(this._email,
          //           this._password, this._reegitratrionid, this._login_as)),
          // );

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
              TextField(
                onChanged: (eValue) {
                  setState(() {
                    _email = eValue;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              TextField(
                onChanged: (pValue) {
                  setState(() {
                    _password = pValue;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Password",
                  label: Text("Enter your password"),
                ),
                obscureText: true,
              ),
              TextField(
                onChanged: (regVelu) {
                  setState(() {
                    _reegitratrionid = regVelu;
                  });
                },
                decoration: InputDecoration(
                  hintText: "reg ID",
                  label: Text("Enter your reg ID"),
                ),
                obscureText: true,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: _login,
                    child: Text("login"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signup_Screen()));
                    },
                    child: Text("signup"),
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
