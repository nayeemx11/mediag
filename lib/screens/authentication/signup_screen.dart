import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediag/screens/updateuserdetails/personInfoupdate.dart';
import 'package:mediag/screens/updateuserdetails/personalInfo.dart';
import 'package:mediag/screens/users/nurse_welcomescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:mediag/welcomescreen.dart';

import '../splash/splash_screen.dart';
import '../users/patient_welcomescreen.dart';
import 'login_screen.dart';

const List<String> list = <String>['Login As', 'Patient', 'Doctor', 'Nurse'];

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
  String _reegitratrionid = '';
  String? _errorText = '';

  int flagNurse = 1;

  void setLoginAs(String login_as) {
    _login_as = login_as;
  }

  // Validate email format
  bool _validateEmail(String value) {
    final emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailPattern.hasMatch(value);
  }

  Future<bool> _emailCheckUser(String email) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('n001')
        .where('email', isEqualTo: email)
        .get();

    return querySnapshot.docs.isEmpty;
  }

  Future<bool> checkIfEmailExists(String email) async {
    try {
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return signInMethods
          .isNotEmpty; // Return true if email is registered, false otherwise
    } catch (e) {
      print('Error checking email existence: $e');
      return false; // Handle errors by returning false
    }
  }

  Future<bool> _signup() async {
    final email = _email;

    if (_user_name.isEmpty ||
        _email.isEmpty ||
        _password.isEmpty ||
        _reegitratrionid.isEmpty ||
        _login_as == list[1]) {
      print("not signed in");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text("Signed Uncessful."),
          ),
        ),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Signup_Screen()));
    }

    if (_validateEmail(email)) {
      setState(() {
        _errorText = null; // Reset error message
      });

      // Do something with the valid email
      print('Valid email: $email');
    } else {
      setState(() {
        _errorText = 'Invalid email format';
      });

      if (await _emailCheckUser(_email)) {
        setState(() {
          _errorText = null;
        });
      } else {
        setState(() {
          _errorText = 'Mail already exists';
        });
      }

      if (await checkIfEmailExists(_email)) {
        _errorText = null;
      } else {
        _errorText = 'Mail already exists';
      }
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (_login_as == "Nurse") {
          DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
              .collection(_reegitratrionid)
              .doc(_login_as)
              .get();

          if (documentSnapshot.exists || _errorText != null) {
            flagNurse = 0;
            return false;
          } else {
            flagNurse = 1;
            _create();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login_Screen()),
              // personalInfoUpdate(_email, _reegitratrionid)),
            );
          }
        } else {
          _create();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login_Screen()),
            // PersonalInformationCard(_email, _reegitratrionid)),
          );
        }
      } catch (error) {
        // Handle signup error
      }
    }

    return true;
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // await _auth.signInWithEmailAndPassword(
        //     email: _email, password: _password);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login_Screen()),
        );
      } catch (error) {
        // Handle login error
      }
    }
  }

  Future<void> _create() async {
    try {
      if (_login_as == "Patient") {
        await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);

        var sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, true);

        // DocumentReference documentReferencePatient = FirebaseFirestore.instance
        //     .collection(_reegitratrionid)
        //     .doc(_user_name)
        //     .collection(_user_name)
        //     .doc(_user_name);

        DocumentReference documentReferencePatient =
            FirebaseFirestore.instance.collection(_reegitratrionid).doc(_email);

        documentReferencePatient.set(
          {
            'user_name': _user_name,
            'email': _email,
            'password': _password,
            'loggin_as': _login_as,
            'registration_id': _reegitratrionid,
          },
        );
        print("patient created");
      } else if (_login_as == "Nurse") {
        await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);

        var sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, true);

        DocumentReference documentReference = FirebaseFirestore.instance
            .collection(_reegitratrionid)
            .doc(_login_as);

        documentReference.set(
          {
            'user_name': _user_name,
            'email': _email,
            'password': _password,
            'loggin_as': _login_as,
            'registration_id': _reegitratrionid,
          },
        );
      }
    } catch (e) {
      _errorText = e.toString();
    }
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (un_value) {
                  setState(() {
                    _user_name = un_value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  labelText: "Enter your User name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (e_value) {
                  setState(() {
                    _email = e_value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.mail),
                  labelText: "Must Enter your Email",
                  // errorText: _errorText,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                obscureText: true,
                onChanged: (p_value) {
                  setState(() {
                    _password = p_value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password),
                  labelText: "Enter your Password",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (rid_value) {
                  setState(() {
                    _reegitratrionid = rid_value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.app_registration),
                  labelText: "Enter your Registration ID",
                ),
              ),
            ),
            SizedBox(
              // color: Colors.purpleAccent,
              height: 52,
              // width: 72,

              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_circle_down_outlined),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  // color: Colors.purpleAccent,
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
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                              builder: (context) => Login_Screen()));
                    },
                    child: Text(
                      "login",
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
                      _signup();
                      if (flagNurse == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.red,
                              ),
                              child: Text("Already have an account."),
                            ),
                          ),
                        );
                      } else if (_user_name.isEmpty ||
                          _email.isEmpty ||
                          _password.isEmpty ||
                          _reegitratrionid.isEmpty ||
                          _login_as == list[1]) {
                        print("not signed in");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.red,
                              ),
                              child: Text("Signed Uncessful."),
                            ),
                          ),
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signup_Screen()));
                      } else {
                        print("signed in");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.green,
                              ),
                              child: Text("Signed in Successfully."),
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
