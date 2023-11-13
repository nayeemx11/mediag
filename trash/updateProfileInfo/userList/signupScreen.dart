// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mediag/screens/authentication/login_screen.dart';
// import 'package:mediag/screens/updateuserdetails/personInfoupdate.dart';
// import 'package:mediag/screens/updateuserdetails/personalInfo.dart';
// // import 'package:mediag/screens/users/nurse_welcomescreen.dart';
// // import 'package:mediag/screens/users/patient_welcomescreen.dart';
// import 'package:mediag/screens/splash/splash_screen.dart';
// // import 'package:mediag/screens/au/login_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// const List<String> userTypes = ['Login As', 'Nurse', 'Patient'];

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({Key? key}) : super(key: key);

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController _userNameController = TextEditingController();
//   final TextEditingController _userMailController = TextEditingController();
//   final TextEditingController _userPassController = TextEditingController();
//   final TextEditingController _userRegIdController = TextEditingController();

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   String _email = '';
//   String _password = '';
//   String _user_name = '';
//   String _login_as = '';
//   String _registrationId = '';
//   String? _errorText = '';

//   int flagNurse = 1;

//   void setLoginAs(String login_as) {
//     _login_as = login_as;
//   }

//   bool _validateEmail(String value) {
//     final emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
//     return emailPattern.hasMatch(value);
//   }

//   Future<bool> _emailCheckUser(String email) async {
//     final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection(_registrationId)
//         .where(_email, isEqualTo: email)
//         .get();

//     return querySnapshot.docs.isEmpty;
//   }

//   Future<bool> checkIfEmailExists(String email) async {
//     try {
//       List<String> signInMethods =
//           await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
//       return signInMethods.isNotEmpty;
//     } catch (e) {
//       print('Error checking email existence: $e');
//       return false;
//     }
//   }

//   Future<bool> _signup() async {
//     final email = _email;

//     if (_validateEmail(email)) {
//       setState(() {
//         _errorText = null;
//       });
//     } else {
//       setState(() {
//         _errorText = 'Invalid email format';
//       });

//       if (await _emailCheckUser(_email) || await checkIfEmailExists(_email)) {
//         _errorText = 'Mail already exists';
//       }
//     }

//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       try {
//         if (_login_as == "Nurse") {
//           DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
//               .collection(_registrationId)
//               .doc(_login_as)
//               .get();

//           if (documentSnapshot.exists || _errorText != null) {
//             flagNurse = 0;
//             return false;
//           } else {
//             flagNurse = 1;
//             _create();

//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => PersonalInformationCard(
//                       email: _email, registrationId: _registrationId)),
//             );
//           }
//         } else {
//           _create();
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     personalInfoUpdate(_email, _registrationId)),
//           );
//         }
//       } catch (error) {
//         print("$error");
//       }
//     }

//     return true;
//   }

//   Future<void> _login() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       try {
//         await _auth.signInWithEmailAndPassword(
//             email: _email, password: _password);

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => Login_Screen()),
//         );
//       } catch (error) {
//         print('Error during login: $error');
//       }
//     }
//   }

//   void updateFirebaseFirestore() {
//     FirebaseFirestore.instance
//         .collection(_registrationId) // Use your collection name here
//         .doc(_email) // Use the document ID (e.g., user's email) as needed
//         .set({
//       'name': _userNameController.text,
//       '_email': _userMailController.text,
//       '_reegitratrionid': _registrationId,
//       '_password': _userPassController,
//       // '_passkey':
//     }).then((_) {
//       // Show a success message, navigate back, or perform other actions
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Information updated successfully'),
//       ));
//     }).catchError((error) {
//       // Handle errors, show an error message, or perform other actions
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error updating information: $error'),
//       ));
//     });
//   }

//   Future<void> _create() async {
//     try {
//       if (_login_as == "Patient" || _login_as == "Nurse") {
//         await _auth.createUserWithEmailAndPassword(
//             email: _email, password: _password);

//         var sharedPreferences = await SharedPreferences.getInstance();
//         sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, true);
//         sharedPreferences.setString(Splash_ScreenState.KEY_EMAIL, _email);
//         sharedPreferences.setString(
//             Splash_ScreenState.KEY_REG, _registrationId);

//         updateFirebaseFirestore();

//         // DocumentReference documentReferencePatient =
//         //     FirebaseFirestore.instance.collection(_registrationId).doc(_email);

//         // documentReferencePatient.set(
//         //   {
//         //     'user_name': _user_name,
//         //     'email': _email,
//         //     'password': _password,
//         //     'loggin_as': _login_as,
//         //     'registration_id': _registrationId,
//         //   },
//         // );
//         print("User created");
//       }
//     } catch (e) {
//       _errorText = e.toString();
//     }
//   }

//   Widget buildTextField(
//       String label, String changeTag, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 16, right: 16),
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width / 2,
//         height: 60,
//         child: TextField(
//           controller: controller,
//           onChanged: (unValue) {
//             setState(() {
//               changeTag = unValue;
//               print(MediaQuery.of(context).size.height);
//             });
//           },
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             labelText: label,
//           ),
//         ),
//       ),
//     );
//   }

//   String dropdownValue = userTypes.first;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sign Up to App"),
//         centerTitle: true,
//       ),
//       body: Container(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               buildTextField("User name: ", _user_name, _userNameController),
//               buildTextField("Email: ", _email, _userMailController),
//               buildTextField("Password: ", _password, _userPassController),
//               buildTextField(
//                   "Registration ID: ", _registrationId, _userRegIdController),
//               DropdownButton<String>(
//                 value: dropdownValue,
//                 icon: const Icon(Icons.arrow_downward),
//                 elevation: 16,
//                 style: const TextStyle(color: Colors.black),
//                 underline: Container(
//                   height: 2,
//                   color: Colors.purpleAccent,
//                 ),
//                 onChanged: (String? value) {
//                   setState(() {
//                     dropdownValue = value!;
//                     _login_as = value;
//                   });
//                 },
//                 items: userTypes.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               Row(
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => Login_Screen()));
//                     },
//                     child: Text("Login"),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       _signup();
//                       if (flagNurse == 0) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Container(
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 color: Colors.red,
//                               ),
//                               child: Text("Already have an account."),
//                             ),
//                           ),
//                         );
//                       } else {
//                         print("signed in");
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Container(
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 color: Colors.green,
//                               ),
//                               child: Text("Signed in Successfully."),
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                     child: Text("Signup"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
