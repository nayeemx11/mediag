import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediag/auth_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  // Future<void> _updateEmail() async {
  //   // Implement your update email logic here
  // }

  // Future<void> _updatePassword() async {
  //   // Implement your update password logic here
  // }

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      User user = _auth.currentUser!;
      // ignore: unnecessary_null_comparison
      if (user != null) {
        await user.delete();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AuthScreen()),
        );
      }
    } catch (error) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'updateEmail') {
                // _updateEmail();
              } else if (value == 'updatePassword') {
                // _updatePassword();
              } else if (value == 'deleteAccount') {
                _deleteAccount(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                // PopupMenuItem<String>(
                //   value: 'updateEmail',
                //   child: Text('Update Email'),
                // ),
                // PopupMenuItem<String>(
                //   value: 'updatePassword',
                //   child: Text('Update Password'),
                // ),
                PopupMenuItem<String>(
                  value: 'deleteAccount',
                  child: Text('Delete Account'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(159, 255, 248, 101), const Color.fromRGBO(255, 133, 197, 235)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Welcome to the App!'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _logout(context),
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
