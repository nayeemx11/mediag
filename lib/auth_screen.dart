import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediag/welcomescreen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  // GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Future<void> _signup() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();

  //     try {
  //       await _auth.createUserWithEmailAndPassword(
  //           email: _email, password: _password);

  //       navigatorKey.currentState!.pushReplacement(
  //         MaterialPageRoute(builder: (context) => WelcomeScreen()),
  //       );
  //     } catch (error) {
  //       // Handle signup error
  //     }
  //   }
  // }

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => WelcomeScreen()),
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

        // navigatorKey.currentState!.pushReplacement(
        //   MaterialPageRoute(builder: (context) => WelcomeScreen()),
        // );
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => WelcomeScreen()),
        // );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      } catch (error) {
        // Handle login error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auth To App')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromRGBO(255, 248, 101, 96),
              const Color.fromRGBO(255, 133, 197, 235)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value!,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value!,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _signup,
                    child: Text('Sign Up'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
