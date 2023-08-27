import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediag/screens/authentication/login_screen.dart';
import 'package:mediag/screens/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension ObjectExtension on Object {
  dynamic operator [](String key) {
    if (this is Map<String, dynamic>) {
      return (this as Map<String, dynamic>)[key];
    }
    return null;
  }
}

class WelcomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _logout(BuildContext context) async {
    await _auth.signOut();

    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => login_Screen()),
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

        var sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, false);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => login_Screen()),
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
              } else if (value == 'logout') {
                _logout(context);
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
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(159, 255, 248, 101),
              const Color.fromRGBO(255, 133, 197, 235)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Text("this welcome screen will be implemented soon"),

          // child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // children: <Widget>[
          // StreamBuilder<QuerySnapshot>(
          //   stream:
          //       FirebaseFirestore.instance.collection('Users').snapshots(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return CircularProgressIndicator();
          //     }
          //     final users = snapshot.data!.docs;
          //     return SizedBox(
          //       height: 500,
          //       child: ListView.builder(
          //         itemCount: users.length,
          //         itemBuilder: (context, index) {
          //           final user = users[index].data()!;
          //           return ListTile(
          //             title: Text(user['name']),
          //             subtitle: Text(user['email']),
          //           );
          //         },
          //       ),
          //     );
          //   },
          // ),
          // Text('Welcome to the App!'),
          // SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: () => _logout(context),
          //   child: Text('Logout'),
          // ),
          // ],
          // ),
        ),
      ),
    );
  }
}
