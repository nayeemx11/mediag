import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mediag/welcomescreen.dart';

import '../splash/splash_screen.dart';
import '../welcome/welcomescreen.dart';
import 'login_screen.dart';

const List<String> list = <String>['Login As', 'Nurse', 'Patient'];

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({super.key});

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _user_name = '';
  String _login_as = '';

  void setLoginAs(String login_as) {
    this._login_as = login_as;
  }

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        _create();

        var sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, true);

        // final db = FirebaseFirestore.instance;

        // db.collection("User").get().then(
        //   (querySnapshot) {
        //     print("Successfully completed");
        //     for (var docSnapshot in querySnapshot.docs) {
        //       print('${docSnapshot.id} => ${docSnapshot.data()}');
        //     }
        //   },
        //   onError: (e) => print("Error completing: $e"),
        // );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      } catch (error) {
        // Handle signup error
      }
    }
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => login_Screen()),
        );
      } catch (error) {
        // Handle login error
      }
    }
  }

  Future<void> _create() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("User").doc(_user_name);

    documentReference.set(
      {
        'user_name': _user_name,
        'email': _email,
        'password': _password,
        'loggin_as': _login_as,
      },
    );
  }

  // void showsome() async {
  //   await FirebaseFirestore.instance.collection("users").get().then((event) {
  //     for (var doc in event.docs) {
  //       print("${doc.id} => ${doc.data()}");
  //     }
  //   });
  // }

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp to App"),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                onChanged: (un_value) {
                  setState(() {
                    _user_name = un_value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "User name",
                ),
              ),
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
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.orange,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                    _login_as = value;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              // DropdownButton(
              //   value: dropdownValue,
              //   icon: const Icon(Icons.menu),
              //   style: const TextStyle(color: Colors.white),
              //   underline: Container(
              //     height: 2,
              //     color: Colors.white,
              //   ),
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       dropdownValue = newValue?? '';
              //     });
              //   },
              //   items: [
              //     DropdownMenuItem<String>(
              //       value: 'Patient',
              //       child: GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             dropdownValue = 'Patient';
              //             setLoginAs(
              //                 "Patient"); // Assuming setLoginAs is a function to set the login role
              //           });
              //         },
              //         child: Text("Patient"),
              //       ),
              //     ),
              //     DropdownMenuItem<String>(
              //       value: 'Nurse',
              //       child: GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             dropdownValue = 'Nurse';
              //             setLoginAs(
              //                 "Nurse"); // Assuming setLoginAs is a function to set the login role
              //           });
              //         },
              //         child: Text("Nurse"),
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => login_Screen()));
                    },
                    child: Text("login"),
                  ),
                  TextButton(
                    onPressed: _signup,
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
