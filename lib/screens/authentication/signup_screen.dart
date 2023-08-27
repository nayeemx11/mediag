import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediag/UserListScreen.dart';
import 'package:mediag/welcomescreen.dart';

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

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        _create();

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
          MaterialPageRoute(builder: (context) => UserListScreen()),
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
          MaterialPageRoute(builder: (context) => UserListScreen()),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore learn"),
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
              Row(
                children: [
                  TextButton(
                    onPressed: _login,
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
