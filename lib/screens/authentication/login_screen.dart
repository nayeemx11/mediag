import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediag/screens/userlist_screen/userListScreen.dart';
import 'package:mediag/screens/authentication/signup_screen.dart';
import 'package:mediag/screens/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../welcome/welcomescreen.dart';

class login_Screen extends StatefulWidget {
  const login_Screen({super.key});

  @override
  State<login_Screen> createState() => _login_ScreenState();
}

class _login_ScreenState extends State<login_Screen> {
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserListScreen()),
          );
        } else {
          // jsut normal user will get the remember me feature
          var sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
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
                onChanged: (e_value) {
                  setState(() {
                    _email = e_value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              TextField(
                onChanged: (p_value) {
                  setState(() {
                    _password = p_value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Password",
                ),
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
