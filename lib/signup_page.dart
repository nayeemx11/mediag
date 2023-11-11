import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class SignUpPage extends StatefulWidget {
  final User? user;

  SignUpPage({this.user});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();

  void sendVerificationEmail() async {
    final ActionCodeSettings acs = ActionCodeSettings(
      url: 'https://mediag.page.link/YaCK',
      handleCodeInApp: true,
      androidPackageName: 'com.example.mediag',
    );

    final String email = emailController.text;

    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: acs,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification email sent. Please check your email.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending verification email: $e'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize Firebase
    Firebase.initializeApp();

    // Handle dynamic links
    handleDynamicLinks();
  }

  Future<void> handleDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data!.link;
    print("deepLink is : $deepLink");
    print("data are: $data");

    if (deepLink != null) {
      if (deepLink.toString() == 'https://mediag.page.link/YaCK') {
        // Link matches the expected verification link
        // You can now sign in the user
        // You may also want to check if the user is already signed in
        // and mark their email as verified in your Firebase Authentication settings
        // based on your application's logic.
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      }
    }

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLink) {
      final Uri deepLink = dynamicLink.link;

      if (deepLink != null) {
        if (deepLink.toString() == 'https://mediag.page.link/YaCK') {
          // Link matches the expected verification link
          // You can now sign in the user
          // You may also want to check if the user is already signed in
          // and mark their email as verified in your Firebase Authentication settings
          // based on your application's logic.
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
        }
      }
    }, onError: (e) {
      // Handle any errors that occur when receiving a dynamic link.
      print('Error handling dynamic link: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed: sendVerificationEmail,
              child: Text('Send Verification Email'),
            ),
            if (widget.user != null && !widget.user!.emailVerified)
              Text('Please verify your email to continue.'),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
